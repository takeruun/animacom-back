class PostImage < ApplicationRecord
  mount_uploader :image, ImagesUploader

  belongs_to :post

  validates :image, presence: true

  def image_path
    ENV['S3_ASSET_HOST'] + image.path
  end
end
