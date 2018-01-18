FactoryBot.define do
  factory :user do
    username 'james'
    email 'james@bitmaker.com'
    password 'abcd1234'
    password_confirmation 'abcd1234'
  end

  factory :user_two do
    username 'kyle'
    email 'kyle@bitmaker.com'
    password 'abcd1234'
    password_confirmation 'abcd1234'
  end
end
