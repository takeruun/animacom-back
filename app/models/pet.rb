class Pet < ApplicationRecord
  belongs_to :user

  mount_uploader :image, ImagesUploader

  validates :name, presence: true
  validates :age, presence: true
  validates :gender, presence: true
  validates :image,  presence: true

  enum gender: {
    men: 0,
    women: 1,
  }

  def image_path
    ENV['S3_ASSET_HOST'] + image.path
  end
end
