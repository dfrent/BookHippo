FactoryBot.define do
  factory :rating do
    stars { Faker::Number.within(1..5) }
    user
    book
  end
end
