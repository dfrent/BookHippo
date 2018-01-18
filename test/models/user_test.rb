require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_user_needs_a_username_to_save
    user = build(:user, username: nil)
    user.save
    refute user.persisted?
  end

  def test_user_needs_a_email_to_save
    user = build(:user, email: nil)
    user.save
    refute user.persisted?
  end

  def test_user_needs_a_password_to_save
    user = build(:user, password: nil)
    user.save
    refute user.persisted?
  end

  def test_user_must_confirm_password_to_save
    user = build(:user, password_confirmation: nil)
    user.save
    refute user.persisted?
  end

  def test_user_does_not_save_when_password_and_confirmation_do_not_match
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

  def test_user_saves_with_unique_email
    user = build(:user)
    user.save

    user2 = build(:user, username: "cordell", email: "cordell@g.com")
    user2.save

    assert user2.persisted?
  end

  def test_user_does_not_save_with_duplicate_email
    user = build(:user)
    user.save

    user2 = build(:user, username: "cordell", email: user.email)
    user2.save

    refute user2.persisted?
  end

  def test_user_does_not_save_with_duplicate_username
    user = build(:user)
    user.save

    user2 = build(:user, username: user.username, email: "cordell@g.com")
    user2.save

    refute user2.persisted?
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

  def test_following_method_returns_true_if_user_is_following
    user = build(:user)
    user2 = build(:user, username: "kyle", email: "kyle@bitmaker.com")
    user.follow(user2)

    assert user.following?(user2)
  end

  def test_following_method_returns_false_if_user_is_not_following
    user = build(:user)
    user2 = build(:user, username: "kyle", email: "kyle@bitmaker.com")

    refute user.following?(user2)
  end

  def test_users_to_follow_does_not_include_current_user
    user = build(:user)
    user2 = build(:user, username: "kyle", email: "kyle@bitmaker.com")

    user_array = User.users_to_follow(2, user)

    refute user_array.include?(user)
  end
end
