require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

# Validation Testing
  def test_user_has_a_username
    user = build(:user, username: nil)
    user.save
    refute user.persisted?
  end

  def test_user_has_a_email
    user = build(:user, email: nil)
    user.save
    refute user.persisted?
  end

  def test_user_has_a_password
    user = build(:user, password: nil)
    user.save
    refute user.persisted?
  end

  def test_user_password_confirmation
    user = build(:user, password_confirmation: nil)
    user.save
    refute user.persisted?
  end

  def test_user_password_and_password_confirmation_match
    user = build(:user, password: "abcd1234", password_confirmation: "wxyz5678")
    user.save
    refute user.persisted?
  end

  def test_user_password_is_minimum_8_characters
    user = build(:user, password: "abc", password_confirmation: "abc")
    user.save
    refute user.persisted?
  end

  def test_user_saves_when_fields_are_correct
    user = build(:user)
    user.save
    assert user.persisted?
  end

  def test_user_can_follow_another_user
    user = build(:user)
    user2 = build(:user, username: "kyle", email: "kyle@bitmaker.com")
    user.follow(user2)

    actual = user.following
    expected = [user2]

    assert_equal(actual, expected)
  end

  def test_user_can_unfollow_another_user
    user = build(:user)
    user2 = build(:user, username: "kyle", email: "kyle@bitmaker.com")
    user.follow(user2)
    user.unfollow(user2)

    actual = user.following
    expected = []

    assert_equal(actual, expected)
  end

end
