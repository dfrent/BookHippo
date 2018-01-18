FactoryBot.define do
  factory :relationship do
    association :follower, factory: :user
    association :followed, factory: :user, username: "Writely", email: "hi@bye.com"
  end
end
