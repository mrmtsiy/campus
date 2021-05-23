class Post < ApplicationRecord
  has_one_attached :post_image
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true
  validates :post_image, presence: true
  validates :user_id, presence: true




end
