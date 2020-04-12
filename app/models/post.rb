class Post < ApplicationRecord
  has_many_attached :images
  belongs_to :user

  def owner?(owner_id)
    self.user_id == owner_id
  end
end
