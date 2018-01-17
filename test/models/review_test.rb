require 'test_helper'

class GenreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

# Validation Testing
  def test_review_needs_a_comment
    comment = build(:review, comment: nil)
    comment.save
    refute comment.persisted?
  end

end
