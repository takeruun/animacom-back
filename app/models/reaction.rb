class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :post

  enum kind: {
    cute: 1,
    fav: 2,
    good: 3,
    cool: 4,
  }
end
