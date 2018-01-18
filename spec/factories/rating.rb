FactoryBot.define do
  factory :rating do
    stars '2'
    user
    book
  end

end
