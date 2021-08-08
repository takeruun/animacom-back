# frozen_string_literal: true

class CommentCreationEventBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment)
    ActionCable
      .server
      .broadcast("comment_channel_#{comment.post_id}",
                  id: comment.id,
                  userId: comment.user_id,
                  userName: User.find(comment.user_id).nickname,
                  postId: comment.post_id,
                  createdAt: comment.created_at,
                  body: comment.body
                )
  end
end
