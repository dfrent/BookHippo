require 'rspec/expectations'

class Book
  def books
    @books ||= []
  end
end

describe Book do
  before(:each) do
    @book = Book.new
  end

  describe 'initialized in before(:each)' do
    it 'has isbn number' do
      @book.should have(1).isbn
    end

    it 'can get accept new widgets' do
      @book.isbn << Book.new
    end

    it 'does not share state across examples' do
      @book.should have(1).widgets
    end
  end
end
