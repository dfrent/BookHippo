# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
genres = Genre.create(
  [
    {name: 'Sci-Fi'},
    {name: 'Fantasy'},
    {name: 'Mystery'}
  ]
)

books = Book.create(
  [
    {title: 'Lord of the Rings', author: 'J.R.R. Tolkien', published_date: Time.now - 20.years, genre_id: 1},
    {title: 'Cat in the Hat', author: 'Dr. Seuss', published_date: Time.now - 35.years, genre_id: 1},
    {title: 'War of the Worlds', author: 'H.G. Wells', published_date: Time.now - 120.years, genre_id: 1},
    {title: 'Lord of the Flies', author: 'Willaim Golding', published_date: Time.now - 73.years, genre_id: 1}
  ]
)

users = User.create(
  [
    {username: "Cordell369", email: "cordell@bitmaker.com", password: "abcd1234", password_confirmation: 'abcd1234'},
    {username: 'kyle', email: 'kyle@bitmaker.com', password: "abcd1234", password_confirmation: 'abcd1234'}
  ]
)

reviews = Review.create(
  [
    {user_id: 1, book_id: 2, comment: 'Best book ever!', stars: 5},
    {user_id: 2, book_id: 3, comment: "Didn't really like it.", stars: 2},
    {user_id: 2, book_id: 4, comment: "Great!", stars: 4}
  ]
)

reading_lists = ReadingList.create(
  [
    {user_id: 1, book_id: 1, read_status: 'want to', date_completed: Time.now},
    {user_id: 1, book_id: 2, read_status: 'currently', date_completed: Time.now},
    {user_id: 1, book_id: 3, read_status: 'finished', date_completed: Time.now},
    {user_id: 2, book_id: 4, read_status: 'want to', date_completed: Time.now},
    {user_id: 2, book_id: 2, read_status: 'currently', date_completed: Time.now},
    {user_id: 2, book_id: 3, read_status: 'finished', date_completed: Time.now}
  ]
)
