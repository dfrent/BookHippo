require 'rails_helper'

RSpec.describe ReadingList, :type => :model do
  # ATTRIBUTES
  it 'is valid with valid attributes' do
    expect(build(:reading_list)).to be_valid
  end

  it 'is valid when read status is want_to_read' do
    expect(build(:reading_list, read_status: 'want_to_read')).to be_valid
  end

  it 'is valid when read status is currently_reading' do
    expect(build(:reading_list, read_status: 'currently_reading')).to be_valid
  end

  it 'is valid when read status is finished_reading' do
    expect(build(:reading_list, read_status: 'finished_reading')).to be_valid
  end

  it 'is not valid without a user' do
    expect(build(:reading_list, user: nil)).not_to be_valid
  end

  it 'is not valid without a book' do
    expect(build(:reading_list, book: nil)).not_to be_valid
  end

  it 'is not valid without a read status' do
    expect(build(:reading_list, read_status: nil)).not_to be_valid
  end

  it 'is not valid if read status is outside of valid options' do
    expect(build(:reading_list, read_status: 'invalid')).not_to be_valid
  end

  # RELATIONSHIPS
  it 'belongs to a user' do
    expect(create(:reading_list).user).to be_present
  end

  it 'belongs to a book' do
    expect(create(:reading_list).book).to be_present
  end

  # METHODS
  describe 'done_reading' do
    it 'sets the date completed to Time.now' do
      reading_list = create(:reading_list)
      expect(reading_list.date_completed).to equal(nil)
      reading_list.done_reading
      expect(reading_list.date_completed).to be_present
    end
  end

  describe 'finished_book?' do
    it 'returns true if done reading' do
      reading_list = create(:reading_list, read_status: 'finished_reading')
      expect(reading_list.finished_book?).to equal(true)
    end

    it 'returns false if want_to_read' do
      reading_list = create(:reading_list, read_status: 'want_to_read')
      expect(reading_list.finished_book?).to equal(false)
    end

    it 'returns false if currently_reading' do
      reading_list = create(:reading_list, read_status: 'currently_reading')
      expect(reading_list.finished_book?).to equal(false)
    end
  end
end
