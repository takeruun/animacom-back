class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'

  validates :follow_id, presence: true
  validates :user_id, uniqueness: { scope: :follow_id }
end
