require 'test_helper'

class ReadingListTest < ActiveSupport::TestCase

# Validation Testing
  def test_reading_list
    reading_list = build(:reading_list)
    reading_list.save
    assert reading_list.persisted?
  end

  def test_done_reading_method_sets_date_completed
    Timecop.freeze(Time.now) do
      reading_list = build(:reading_list)
      reading_list.save
      reading_list.done_reading

      actual = reading_list.date_completed
      expected = Time.now.to_datetime
      assert_equal(actual, expected)
    end
  end

  def test_read_status_when_finished_book
    reading_list = build(:reading_list)
    reading_list.save

    actual = reading_list.finished_book?
  end


end
