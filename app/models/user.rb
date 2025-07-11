class User < ApplicationRecord
  has_many :photos, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :likes, dependent: :destroy
  mount_uploader :avatar, FeaturedImageUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_follows

  has_many :passive_follows, class_name: "Follow", foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :passive_follows

  enum :role, [ :user, :admin ], default: :user
  after_initialize :set_default_role, if: :new_record?


  def liked?(likeable)
      likes.exists?(likeable: likeable)
  end

  private
  def set_default_role
    self.role ||= :user
  end
end
