# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Genre.destroy_all

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

users = User.create(
  [
    {username: "Cordell369", email: "cordell@bitmaker.com", password: "abcd1234", password_confirmation: 'abcd1234'},
    {username: 'kyle', email: 'kyle@bitmaker.com', password: "abcd1234", password_confirmation: 'abcd1234'}
  ]
)
