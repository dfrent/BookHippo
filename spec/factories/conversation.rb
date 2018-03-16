FactoryBot.define do
  factory :conversation do
    association :sender, factory: :user
    association :recipient, factory: :user, username: 'Writely', email: 'hi@bye.com'
  end
end
