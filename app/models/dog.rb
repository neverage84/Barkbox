class Dog < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  has_many :likes
  def liked?(user)
    !!self.likes.find{|like| like.user_id == user.id}
  end
end
