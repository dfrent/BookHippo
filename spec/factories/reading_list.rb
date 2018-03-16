FactoryBot.define do
  factory :reading_list do
    read_status 'want_to_read'
    book
    user
  end
end
