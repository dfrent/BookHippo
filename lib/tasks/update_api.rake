# Load Rails
# ENV['RAILS_ENV'] = ARGV[0] || 'production'
require File.dirname(__FILE__) + '/../../config/environment'

namespace :update_api do
  desc 'Update NY Times API'
  task :ny_times do
    puts "Updating NY Times List book data..."
    response = HTTParty.get("https://api.nytimes.com/svc/books/v3/lists.json?api-key=#{ENV['NYTIMES_KEY']}&list=mass-market-paperback")
    response_travel = HTTParty.get("https://api.nytimes.com/svc/books/v3/lists.json?api-key=#{ENV['NYTIMES_KEY']}&list=travel")
    response_science = HTTParty.get("https://api.nytimes.com/svc/books/v3/lists.json?api-key=#{ENV['NYTIMES_KEY']}&list=science")
    response_business = HTTParty.get("https://api.nytimes.com/svc/books/v3/lists.json?api-key=#{ENV['NYTIMES_KEY']}&list=business-books")
    response_animals =         HTTParty.get("https://api.nytimes.com/svc/books/v3/lists.json?api-key=#{ENV['NYTIMES_KEY']}&list=animals")

    items = []
    items << response.parsed_response['results']
    items << response_travel.parsed_response['results']
    items << response_science.parsed_response['results']
    items << response_business.parsed_response['results']
    items << response_animals.parsed_response['results']
    puts 'Starting'

    items.each do |item|
      item.each do |result|
        isbn = result['book_details'][0]['primary_isbn10']
        list = result['list_name']
        book = Book.find_or_api_call(isbn)
        book.ny_times_list = list
        book.save
        puts book.title + ' found or created.'
      end
    end
  end

  desc 'Update Google API for recommendations'
  task :google_rec do
    puts "Updating genre recommendations from Google Books API"
    genres = Genre.all

    genres.each do |genre|
      name = genre.name
      id = genre.id
      response =  HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=subject=#{name}&key=#{ENV['GBOOKS_KEY']}")
      items = response.parsed_response["items"]

      items.each do |item|
        identifiers = item["volumeInfo"]["industryIdentifiers"]
        isbn = nil

        if identifiers
          identifiers.each do |identifier|
            if identifier.has_value?("ISBN_10")
              isbn = identifier["identifier"]
            end
          end
        end

        if isbn == nil
          next
        else
          if Book.exists?(isbn)
            next
          else
            info = item["volumeInfo"]
            authors = info["authors"]
            if authors
              authors_string = authors.join(", ")
            end
            # google_id = response.parsed_response["items"][item]["id"]
            book = Book.create(isbn: isbn, title: info["title"], author: authors_string, description: info["description"], book_cover: info["imageLinks"]["thumbnail"], small_thumbnail: info["imageLinks"]["smallThumbnail"], genre_id: id, page_count: info["pageCount"], average_rating: info["averageRating"], published_date: info["publishedDate"], publisher: info["publisher"])
            puts book.title + ' created.'
          end
        end
      end
    end
  end
end
