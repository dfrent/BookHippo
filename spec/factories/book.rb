FactoryBot.define do
  factory :book do
    isbn { Faker::Number.number(10) }
    title { Faker::Lorem.characters(15) }
    author { Faker::Name.name_with_middle }
    book_cover { Faker::LoremFlickr.image }
    description { Faker::Lorem.sentence }
    genre
  end
end
