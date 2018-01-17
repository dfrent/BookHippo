require 'test_helper'

class RatingTest < ActiveSupport::TestCase

# Validation Testing
  def test_rating_needs_a_star
    rating = build(:rating, stars: nil)
    rating.save
    refute rating.persisted?
  end

  def test_rating_star_needs_to_be_an_integer
    rating = build(:rating, stars: "hey")
    rating.save
    refute rating.persisted?
  end

  def test_rating_must_be_between_0_and_5
    rating = build(:rating, stars: 7)
    rating.save
    refute rating.persisted?
  end

  def test_rating_can_be_destroyed
    rating = build(:rating)
    rating.destroy
    refute rating.persisted?
  end


end
