class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image
  has_many :posts, dependent: :destroy

#いいね機能の関連付け
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

#フォロー機能の関連付け
  has_many :active_relationships, class_name: "Follow", foreign_key: "user_id"
  has_many :passive_relationships, class_name: "Follow", foreign_key: "target_user_id"
  has_many :followings, through: :active_relationships, source: :target_user
  has_many :followers, through: :passive_relationships, source: :user


  validates :username, presence: true
  validates :email, presence: true
  validates :profile, length: { maximum: 200 }


  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
  

  def update_without_current_password(params, *options)
  params.delete(:current_password)
  
    if params[:password].blank? && params[:password_confirmation].blank? 
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    
    result = update(params, *options)
    clean_up_passwords
    result
  end

  
end
