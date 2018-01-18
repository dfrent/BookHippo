FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "james #{n}" }
    sequence(:email) { |n|  "james#{n}@bitmaker.com" }
    password 'abcd1234'
    password_confirmation 'abcd1234'
  end

end
