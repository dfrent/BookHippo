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

User.create!(username: "HungryHippo", email: "hungry@hippo.com", password: "abcd1234", password_confirmation: "abcd1234")
User.create!(username: "Cordell", email: "cordell@bitmaker.co", password: "abcd1234", password_confirmation: "abcd1234")
User.create!(username: "Eric", email: "eric@bitmaker.co", password: "abcd1234", password_confirmation: "abcd1234")
User.create!(username: "James", email: "james@bitmaker.co", password: "abcd1234", password_confirmation: "abcd1234")
User.create!(username: "Kyle", email: "kyle@bitmaker.co", password: "abcd1234", password_confirmation: "abcd1234")

Book.find_or_api_call("0553391860")
Book.find_or_api_call("1455589918")
Book.find_or_api_call("1101987995")
Book.find_or_api_call("0765388103")

BookClub.create!(name: "Book Ends", book: Book.first, user: User.first, description: "More than just ends and odds... Weekly book selection for rotating genres!", goal: "1 book per week")
BookClub.create!(name: "Just Read It.", book: Book.second, user: User.second, description: "Monthly book club for fiction books.", goal: "1 book per month")
BookClub.create!(name: "Classics! Classics! Classics!", book: Book.third, user: User.third, description: "Read all of the best classics!", goal: "1 book per week")
BookClub.create!(name: "Page Turners", book: Book.fourth, user: User.fourth, description: "Selection of the finest nonfiction books", goal: "1 book per month")

Subscription.create!(book_club: BookClub.first, user: User.first)
Subscription.create!(book_club: BookClub.second, user: User.first)
Subscription.create!(book_club: BookClub.third, user: User.first)
Subscription.create!(book_club: BookClub.find(4), user: User.first)
Subscription.create!(book_club: BookClub.first, user: User.second)
Subscription.create!(book_club: BookClub.second, user: User.second)
Subscription.create!(book_club: BookClub.third, user: User.second)
Subscription.create!(book_club: BookClub.find(4), user: User.second)
Subscription.create!(book_club: BookClub.first, user: User.third)
Subscription.create!(book_club: BookClub.second, user: User.third)
Subscription.create!(book_club: BookClub.third, user: User.third)
Subscription.create!(book_club: BookClub.find(4), user: User.third)
Subscription.create!(book_club: BookClub.first, user: User.find(4))
Subscription.create!(book_club: BookClub.second, user: User.find(4))
Subscription.create!(book_club: BookClub.third, user: User.find(4))
Subscription.create!(book_club: BookClub.find(4), user: User.find(4))
Subscription.create!(book_club: BookClub.first, user: User.find(5))
Subscription.create!(book_club: BookClub.second, user: User.find(5))
Subscription.create!(book_club: BookClub.third, user: User.find(5))
Subscription.create!(book_club: BookClub.find(4), user: User.find(5))
