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

  def test_finished_book_is_true_when_finished_reading
    reading_list = build(:reading_list)
    reading_list.save
    reading_list.read_status = "finished_reading"

    assert reading_list.finished_book?
  end

  def test_finished_book_is_false_when_not_finished_reading
    reading_list = build(:reading_list)
    reading_list.save
    reading_list.read_status = "want_to_read"

    refute reading_list.finished_book?
  end

  def test_reading_list_saves_when_read_status_is_want_to_read
    reading_list = build(:reading_list)
    reading_list.save

    assert reading_list.persisted?
  end

  def test_reading_list_saves_when_read_status_is_currently_reading
    reading_list = build(:reading_list, read_status: "currently_reading")
    reading_list.save

    assert reading_list.persisted?
  end

  def test_reading_list_saves_when_read_status_is_finished_reading
    reading_list = build(:reading_list, read_status: "finished_reading")
    reading_list.save

    assert reading_list.persisted?
  end

  def test_reading_list_does_not_save_when_read_status_is_not_in_accepted_list
    reading_list = build(:reading_list, read_status: "hi there!")
    reading_list.save

    refute reading_list.persisted?
  end

  def test_reading_list_does_not_save_without_read_status
    reading_list = build(:reading_list, read_status: nil)
    reading_list.save

    refute reading_list.persisted?
  end

  def test_reading_list_saves_when_read_status_is_in_accepted_list
    reading_list = build(:reading_list)
    reading_list.save

    assert reading_list.persisted?
  end

end
