FactoryBot.define do
  factory :readinglist do
    read_status "finished_reading"
    book
    user
  end

end
