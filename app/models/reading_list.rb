class ReadingList < ApplicationRecord
  belongs_to :user
  has_many :books

  validates :read_status, inclusion:{in:  %w(want_to_read currently_reading finished_reading)}
end
