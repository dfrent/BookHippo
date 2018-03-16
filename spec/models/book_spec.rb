require 'rails_helper'

# RSpec.describe Book, :type => :model do
#   context "with 2 or more comments" do
#     it "orders them in reverse chronologically" do
#       post = Book.create!
#       comment1 = post.comments.create!(:body => "first comment")
#       comment2 = post.comments.create!(:body => "second comment")
#       expect(post.reload.comments).to eq([comment2, comment1])
#     end
#   end
# end
# #
# #

RSpec.describe Book, :type => :model do
  it 'is valid with valid attributes' do
    expect(Book.new).to be_valid
  end
  it 'is not valid without a isbn'
  it 'is not valid without a title'
  it 'is not valid without a author'
  it 'is not valid without a description'
  it 'is not valid without a book_cover'
  it 'is not valid without a small_thumbnail'
  it 'is not valid without a genre_id'
  it 'is not valid without a google_id'
  it 'is not valid without a page_count'
  it 'is not valid without a average_rating'
  it 'is not valid without a published_date'
end

RSpec.describe Book, :type => :model do
  subject { described_class.new }
  it 'is not valid without a isbn' do
    subject.isbn = nil
    expect(subject).to_not be_valid
  end
end
