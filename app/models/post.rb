class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :category_id, presence: true

  belongs_to :user
  belongs_to :category
  has_many :post_images
end
