FactoryBot.define do
  factory :genre do
    name { Faker::Lorem.characters(6) }
  end
end
