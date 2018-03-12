require 'test_helper'

class RatingTest < ActiveSupport::TestCase

  # Validation Testing
  def test_rating_does_not_save_without_stars
    rating = build(:rating, stars: nil)
    rating.save
    refute rating.persisted?
  end

  def test_rating_saves_when_it_has_stars
    rating = build(:rating)
    rating.save
    assert rating.persisted?
  end

  def test_rating_does_not_save_when_star_is_not_integer
    rating = build(:rating, stars: "hey")
    rating.save
    refute rating.persisted?
  end

  def test_rating_saves_when_star_is_integer
    rating = build(:rating, stars: "3")
    rating.save
    assert rating.persisted?
  end

  def test_rating_does_not_save_when_stars_are_greater_than_five
    rating = build(:rating, stars: 7)
    rating.save
    refute rating.persisted?
  end

  def test_rating_does_not_save_when_stars_are_less_than_zero
    rating = build(:rating, stars: -1)
    rating.save
    refute rating.persisted?
  end

  def test_rating_can_be_destroyed
    rating = build(:rating)
    rating.destroy
    refute rating.persisted?
  end
end
