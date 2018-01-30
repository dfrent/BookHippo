require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  def test_review_saves_with_a_comment
    comment = build(:review)
    comment.save
    assert comment.persisted?
  end

  def test_review_does_not_save_without_comment
    comment = build(:review, comment: nil)
    comment.save
    refute comment.persisted?
  end

  def test_username_display_shows_reviews_users_username
    review = build(:review)
    actual = review.username_display
    expected = review.user.username.capitalize

    assert_equal(actual, expected)
  end
end
