FactoryBot.define do
  factory :book do
    isbn '123456789'
    title 'Big Red'
    author 'Thomas the Tank'
    average_rating '3'
    book_cover 'poster'
    description 'history'
    genre
  end
end

#   factory :random_book do
#     isbn {Faker::Number.(10)}
#     title {Faker::Name.title}
#     author {Faker::Name.author}
#     average_rating {Faker::Number.between(1, 5)
#     active true
#   end
# end
