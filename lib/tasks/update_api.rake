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
    google = Tools::Google.new
    google.update_books_by_genre
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
