require 'test_helper'

class GenreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

# Validation Testing
  def test_genre_needs_a_username
    genre = build(:genre, name: nil)
    genre.save
    refute genre.persisted?
  end

end
