# Load Rails
# ENV['RAILS_ENV'] = ARGV[0] || 'production'
require File.dirname(__FILE__) + '/../../config/environment'

namespace :update_api do
  desc 'Update NY Times API'
  task :ny_times do
    response = HTTParty.get("https://api.nytimes.com/svc/books/v3/lists.json?api-key=#{ENV['NYTIMES_KEY']}&list=mass-market-paperback")

    puts "Starting"
    response.parsed_response["results"].each do |result|

      isbn = result["book_details"][0]["primary_isbn10"]
      list = result["list_name"]
      book = Book.find_or_api_call(isbn)
      book.ny_times_list = "mass-market-paperback"
      book.save
      puts book.title + " found or created."
      puts book.ny_times_list
    end
  end
end
