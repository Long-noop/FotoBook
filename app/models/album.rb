class Album < ApplicationRecord
  enum :mode, [ :private_mode, :public_mode ], default: :public_mode
  scope :public_only, -> { where(mode: :public_mode) }

  has_many :album_photos, dependent: :destroy
  has_many :photos, through: :album_photos
  has_many :likes, as: :likeable
  accepts_nested_attributes_for :photos

  belongs_to :user

  validates :title, presence: true
end
