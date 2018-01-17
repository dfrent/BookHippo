class ReadingList < ApplicationRecord
  before_save :done_reading, if: :finished_book?

  belongs_to :user
  belongs_to :book

  validates :read_status, inclusion:{in:  ["want_to_read", "currently_reading", "finished_reading"]}
  validates :read_status, presence: true

  def done_reading
    self.date_completed = Time.now
  end

  def finished_book?
    read_status == "finished_reading"
  end

end
