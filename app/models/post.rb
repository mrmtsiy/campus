class Post < ApplicationRecord
  has_one_attached :post_image
  acts_as_taggable
  belongs_to :user
#いいね機能の関連付け
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
#コメント機能の関連付け
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
  validates :post_image, presence: true
  validates :user_id, presence: true


  # def user
  #   return User.find_by(id: self.user_id)
  # end

end
