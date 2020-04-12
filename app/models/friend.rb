class Friend < ApplicationRecord
  enum status: [:pending, :accepted, :rejected]
  before_create :set_status
  has_many :posts
  has_many :comments

  def set_status
    self.status = 'pending'
  end
end
