class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates_uniqueness_of :post_id, scope: :user_id

  enum kind: {
    cute: 1,
    fav: 2,
    good: 3,
    cool: 4,
  }
end
