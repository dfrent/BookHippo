require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def test_relationship_saves_when_follower_and_followed_are_present
    relationship = build(:relationship)
    relationship.save

    assert relationship.persisted?
  end

  def test_relationship_does_not_save_without_follower
    relationship = build(:relationship)
    relationship.follower = nil
    relationship.save

    refute relationship.persisted?
  end

  def test_relationship_does_not_save_without_followed
    relationship = build(:relationship)
    relationship.followed = nil
    relationship.save

    refute relationship.persisted?
  end

  def test_relationship_does_not_save_if_follower_and_followed_are_same_user
    relationship = build(:relationship)
    relationship.followed = relationship.follower
    relationship.save

    refute relationship.persisted?
  end
end
