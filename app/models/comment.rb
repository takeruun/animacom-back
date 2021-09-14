class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create_commit do
    CommentCreationEventBroadcastJob.perform_later(self)
  end
end
