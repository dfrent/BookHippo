FactoryBot.define do
  factory :rejected_isbn do
    isbn { Faker::Number.number(10) }
  end
end
