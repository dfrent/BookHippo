require 'test_helper'

class GenreTest < ActiveSupport::TestCase
  # test 'the truth' do
  #   assert true
  # end

  # Validation Testing
  def test_genre_does_not_save_without_name
    genre = build(:genre, name: nil)
    genre.save
    refute genre.persisted?
  end

  def test_genre_saves_with_a_name
    genre = build(:genre)
    genre.save
    assert genre.persisted?
  end

  def test_genre_save_when_name_is_unique
    genre = build(:genre)
    genre.save

    genre2 = build(:genre, name: 'horror')
    genre2.save

    assert genre2.persisted?
  end

  def test_genre_will_not_save_when_name_is_not_unique
    genre = build(:genre)
    genre.save

    genre2 = build(:genre, name: 'drama')
    genre2.save

    refute genre2.persisted?
  end
end
