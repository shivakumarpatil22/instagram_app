class Friend < ApplicationRecord
  enum status: [:pending, :accepted, :rejected]
  before_create :set_status
  has_many :posts
  has_many :comments

  scope :friend_request, ->(user_id,friend_id){ where("user_id = ? and friend_id = ?", user_id, friend_id).or(Friend.where("user_id = ? and friend_id = ?", friend_id, user_id))}

  def self.cancel_friend_request?(user_id, friend_id)
    (Friend.friend_request(user_id,friend_id).pending.count > 0 || Friend.friend_request(user_id,friend_id).accepted.count > 0)
  end

  def set_status
    self.status = 'pending'
  end
end
