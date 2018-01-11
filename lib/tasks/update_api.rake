# Load Rails
# ENV['RAILS_ENV'] = ARGV[0] || 'production'
require File.dirname(__FILE__) + '/../../config/environment'

namespace :update_api do
  desc 'Update NY Times API'
  task :ny_times do
    response = HTTParty.get("https://api.nytimes.com/svc/books/v3/lists.json?api-key=#{ENV['NYTIMES_KEY']}&list=mass-market-paperback")
    response_travel = HTTParty.get("https://api.nytimes.com/svc/books/v3/lists.json?api-key=#{ENV['NYTIMES_KEY']}&list=travel")
    response_science = HTTParty.get("https://api.nytimes.com/svc/books/v3/lists.json?api-key=#{ENV['NYTIMES_KEY']}&list=science")
    response_business = HTTParty.get("https://api.nytimes.com/svc/books/v3/lists.json?api-key=#{ENV['NYTIMES_KEY']}&list=business-books")

    items = []
    items << response.parsed_response['results']
    items << response_travel.parsed_response['results']
    items << response_science.parsed_response['results']
    items << response_business.parsed_response['results']
    puts 'Starting'

    items.each do |item|
      item.each do |result|
        isbn = result['book_details'][0]['primary_isbn10']
        list = result['list_name']
        book = Book.find_or_api_call(isbn)
        book.ny_times_list = list
        book.save
        puts book.title + ' found or created.'
        puts book.ny_times_list
      end
    end
  end
end
