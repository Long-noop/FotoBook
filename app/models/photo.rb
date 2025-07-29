class Photo < ApplicationRecord
  PER_PAGE = 4

  enum :mode, [ :private_mode, :public_mode ], default: :private_mode
  scope :public_only, -> { where(mode: :public_mode) }

  has_rich_text :desc
  validates :title, presence: true
  belongs_to :user

  has_many :album_photos, dependent: :destroy
  has_many :albums, through: :album_photos
  has_many :likes, as: :likeable
  mount_uploader :featured_image, FeaturedImageUploader
end
