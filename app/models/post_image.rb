class PostImage < ApplicationRecord
  mount_uploader :image, ImagesUploader

  belongs_to :post

  validates :image, presence: true
end
