class User < ApplicationRecord
  PER_PAGE = 10

  paginates_per PER_PAGE
  has_many :photos, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :likes, dependent: :destroy
  mount_uploader :avatar, FeaturedImageUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [ :google_oauth2 ]


  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_follows

  has_many :passive_follows, class_name: "Follow", foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :passive_follows

  enum :role, [ :regular_user, :admin ], default: :regular_user
  after_initialize :set_default_role, if: :new_record?

  enum :status, [ :inactive, :active ], default: :active

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data["email"]).first

    unless user
        user = User.create(
          email: data["email"],
          password: Devise.friendly_token[0, 20]
        )
    end
    user
  end


  def liked?(likeable)
      likes.exists?(likeable: likeable)
  end

  def follow(other_user)
    followings << other_user unless self == other_user || followings.include?(other_user)
  end

  def unfollow(other_user)
    followings.delete(other_user)
  end

  private
  def set_default_role
    self.role ||= :regular_user
  end
end
