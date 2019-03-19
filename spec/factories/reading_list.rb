FactoryBot.define do
  factory :reading_list do
    read_status %w[want_to_read currently_reading finished_reading].sample
    book
    user
  end
end
