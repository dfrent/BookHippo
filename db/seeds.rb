# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Genre.destroy_all
User.destroy_all
BookClub.destroy_all


Genre.create!(name: "classics")
Genre.create!(name: "fantasy")
Genre.create!(name: "mystery")
Genre.create!(name: "teen")
Genre.create!(name: "art")
Genre.create!(name: "computers")
Genre.create!(name: "business")
Genre.create!(name: "entertainment")
Genre.create!(name: "fiction")
Genre.create!(name: "health")
Genre.create!(name: "history")
Genre.create!(name: "comedy")
Genre.create!(name: "romance")
Genre.create!(name: "cooking")
Genre.create!(name: "science")
Genre.create!(name: "nature")
Genre.create!(name: "sports")
Genre.create!(name: "travel")
Genre.create!(name: "culture")
Genre.create!(name: "misc")


User.create!(username: "Cordell", email: "cordell@bitmaker.co", password: "abcd1234", password_confirmation: "abcd1234")
User.create!(username: "Eric", email: "eric@bitmaker.co", password: "abcd1234", password_confirmation: "abcd1234")
User.create!(username: "James", email: "james@bitmaker.co", password: "abcd1234", password_confirmation: "abcd1234")
User.create!(username: "Kyle", email: "kyle@bitmaker.co", password: "abcd1234", password_confirmation: "abcd1234")
User.create!(username: "HungryHippo", email: "hungry@hippo.com", password: "abcd1234", password_confirmation: "abcd1234")


BookClub.create!(name: "Book Ends", book_id: 1, user_id: 1 , description: "More then just ends and odds... Weekly book selection for rotating genres!", goal: "1 book per week")
BookClub.create!(name: "Just Read It.", book_id: 2, user_id: 2 , description: "Monthly book club for fiction books.", goal: "1 book per month")
BookClub.create!(name: "Classics! Classics! Classics!", book_id: 3, user_id: 3 , description: "Read all of the best classics!", goal: "1 book per week")
BookClub.create!(name: "Page Turners", book_id: 4, user_id: 4 , description: "Selection of the finest nonfiction books", goal: "1 book per month")
