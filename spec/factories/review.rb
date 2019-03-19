FactoryBot.define do
  factory :review do
    comment { Faker::Lorem.sentence }
    user
    book
  end
end
