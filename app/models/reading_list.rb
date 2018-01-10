class ReadingList < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :read_status, inclusion:{in:  ["want_to_read", "currently_reading", "finished_reading"]}

end
