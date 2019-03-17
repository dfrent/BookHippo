# frozen_string_literal: true

# Load Rails
# ENV['RAILS_ENV'] = ARGV[0] || 'production'
require File.dirname(__FILE__) + '/../../config/environment'

namespace :update do
  desc 'Run all tasks'
  task :all do
    Rake::Task['update:ny_times'].invoke
    Rake::Task['update:google_rec'].invoke
    Rake::Task['update:images'].invoke
    puts 'Your app should be running now!'
  end

  desc 'Update books pulled from NY TIMES API'
  task :ny_times do
    puts 'Updating NY Times books'
    ny_times = Tools::NyTimes.new
    ny_times.populate_ny_times_books
  end

  desc 'Update Google API for genre recommendations'
  task :google_rec do
    puts 'Updating genre recommendations from Google Books API'
    google = Tools::Google.new
    google.update_books_by_genre
  end

  desc 'Add images to books in the database'
  task :images do
    puts 'Adding images from Google Books API'
    google = Tools::Google.new
    google.assign_images_to_all_books
  end
end
