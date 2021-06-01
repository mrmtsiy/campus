class Post < ApplicationRecord
  has_one_attached :post_image
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  validates :title, presence: true
  validates :content, presence: true
  validates :post_image, presence: true
  validates :user_id, presence: true


  # def user
  #   return User.find_by(id: self.user_id)
  # end

end
