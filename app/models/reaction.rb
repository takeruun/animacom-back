class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validate :uniq_reaction?

  enum kind: {
    cute: 1,
    fav: 2,
    good: 3,
    cool: 4,
  }

  private

  def uniq_reaction?
    errors.add(:kind, 'は各1回しかできません。') if user.reactions.find_by(post_id: post.id, kind: kind).present?
  end
end
