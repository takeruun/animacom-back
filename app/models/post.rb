class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :category_id, presence: true

  belongs_to :user
  belongs_to :category
  has_many :images, class_name: 'PostImage', dependent: :destroy
  has_many :reactions

  def cute_count
    reactions.where(kind: Reaction.kinds[:cute]).count
  end

  def fav_count
    reactions.where(kind: Reaction.kinds[:fav]).count
  end

  def good_count
    reactions.where(kind: Reaction.kinds[:good]).count
  end

  def cool_count
    reactions.where(kind: Reaction.kinds[:cool]).count
  end
end
