class Pet < ApplicationRecord
  belongs_to :user

  mount_uploader :image, ImagesUploader

  validates :name, presence: true
  validates :age, presence: true
  validates :gender, presence: true

  enum gender: {
    men: 0,
    women: 1,
  }
end
