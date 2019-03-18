FactoryBot.define do
  factory :message do
    body { Faker::Lorem.sentence }
    conversation
  end
end
