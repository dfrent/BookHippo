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
      book = Book.find_or_api_call(isbn)
      next unless book
      book.update_attribute(:ny_times_list, book_info['list_name'])
      puts "#{book_info['book_details'][0]['title']} succesfully updated"
    end
  end

  desc 'Update Google API for genre recommendations'
  task :google_rec do
    puts 'Updating genre recommendations from Google Books API'
    genres = Genre.all

    genres.each do |genre|
      fetch_google_books_list(genre.name).each do |item|
        book_information = item['volumeInfo']
        isbn = find_isbn10_value(book_information['industryIdentifiers'])
        next if isbn.nil? || Book.exists?(isbn)

        book = book_from_google_genres(isbn, book_information, genre)
        next if book.nil?
        puts "#{book.title} has been created"
        puts "#{book.title} has attached images" unless assign_book_images(book, book_information).nil?
      end
    end
  end
end

private

# NY Times Private Methods
def fetch_ny_times_list(list_name)
  HTTParty.get("https://api.nytimes.com/svc/books/v3/lists.json?api-key=#{ENV['NYTIMES_KEY']}&list=#{list_name}")
end

def build_ny_times_list
  categories = %w[mass-market-paperback travel science business-books animals education hardcover-nonfiction]
  categories.each_with_object([]) do |category, response|
    results = fetch_ny_times_list(category).parsed_response['results']
    next if results.nil?
    results.each do |result|
      response << result
    end
  end
end

# Google Books Private Methods
def fetch_google_books_list(name)
  response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=subject=#{name}&key=#{ENV['GBOOKS_KEY']}")
  response.parsed_response['items']
end

def find_isbn10_value(isbns)
  isbns&.each do |identifier|
    return identifier['identifier'] if identifier['type'] == 'ISBN_10'
  end
  nil
end

def book_from_google_genres(isbn, book_information, genre)
  authors = book_information['authors'].join(', ') if book_information['authors']
  book = Book.new(isbn: isbn,
                  title: book_information['title'],
                  author: authors,
                  description: book_information['description'],
                  genre_id: genre.id,
                  page_count: book_information['pageCount'],
                  average_rating: book_information['averageRating'],
                  published_date: book_information['publishedDate'],
                  publisher: book_information['publisher'])
  return unless assign_book_images(book, book_information) && book.valid?
  book.save!
  book
end

def assign_book_images(book, book_information)
  return unless book_information['imageLinks']
  puts "Images successfully added to #{book.title}"
  book.update_attributes(book_cover: book_information['imageLinks']['thumbnail'],
                         small_thumbnail: book_information['imageLinks']['smallThumbnail'])
  book
end
