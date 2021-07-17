class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :category_id, presence: true

  belongs_to :user
  belongs_to :category
  has_many :images, class_name: 'PostImage', dependent: :destroy
  has_many :reactions

  scope :kind_best_5, -> (kind) { left_outer_joins(:reactions)
                                    .where("reactions.kind = #{kind}")
                                    .group('posts.id')
                                    .select('posts.*, COUNT(reactions.id) AS cutes_count')
                                    .distinct
                                    .reorder(cutes_count: :desc)
                                    .limit(5)
                                  }

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
