FactoryBot.define do
  factory :message do
    body { Faker::Lorem.sentence }
    conversation
    user
  end
end
