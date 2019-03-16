# frozen_string_literal: true

# Load Rails
# ENV['RAILS_ENV'] = ARGV[0] || 'production'
require File.dirname(__FILE__) + '/../../config/environment'

namespace :update_api do
  desc 'Update books pulled from NY TIMES API'
  task :ny_times do
    puts 'Updating...'
    build_ny_times_list.each do |book_info|
      isbn = book_info['book_details'][0]['primary_isbn10']
      next unless isbn
      Book.find_or_api_call(isbn).update_attribute(:ny_times_list, book_info['list_name'])
      puts "#{book_info['book_details'][0]['title']} succesfully updated"
    end
  end

  desc 'Update Google API for genre recommendations'
  task :google_rec do
    puts 'Updating genre recommendations from Google Books API'
    genres = Genre.all

    genres.each do |genre|
      name = genre.name
      id = genre.id
      response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=subject=#{name}&key=#{ENV['GBOOKS_KEY']}")
      items = response.parsed_response['items']

      items.each do |item|
        identifiers = item['volumeInfo']['industryIdentifiers']
        isbn = nil

        identifiers&.each do |identifier|
          isbn = identifier['identifier'] if identifier.value?('ISBN_10')
        end

        if isbn.nil?
          next
        else
          if Book.exists?(isbn)
            next
          else
            info = item['volumeInfo']
            authors = info['authors']
            authors_string = authors.join(', ') if authors
            # google_id = response.parsed_response['items'][item]['id']
            book = Book.create(isbn: isbn,
                               title: info['title'],
                               author: authors_string,
                               description: info['description'],
                               book_cover: info['imageLinks']['thumbnail'],
                               small_thumbnail: info['imageLinks']['smallThumbnail'],
                               genre_id: id, page_count: info['pageCount'],
                               average_rating: info['averageRating'],
                               published_date: info['publishedDate'],
                               publisher: info['publisher'])
            puts book.title + ' created.'
          end
        end
      end
    end
  end
end

private

def fetch_ny_times_list(list_name)
  url = "https://api.nytimes.com/svc/books/v3/lists.json?api-key=#{ENV['NYTIMES_KEY']}&list=#{list_name}"
  HTTParty.get(url)
end

def build_ny_times_list
  categories = %w[mass-market-paperback travel science business-books animals education hardcover-nonfiction]
  categories.each_with_object([]) do |category, response|
    results = fetch_ny_times_list(category).parsed_response['results']
    results.each do |result|
      response << result
    end
  end
end
