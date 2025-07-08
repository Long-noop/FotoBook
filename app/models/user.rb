class User < ApplicationRecord
  has_many :photos, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :likes, dependent: :destroy

  mount_uploader :avatar, FeaturedImageUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def liked?(likeable)
      likes.exists?(likeable: likeable)
  end
end
