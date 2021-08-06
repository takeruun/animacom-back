# frozen_string_literal: true

class CommentCreationEventBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment)
    ActionCable
      .server
      .broadcast("comment_channel_#{comment.post_id}",
                  id: comment.id,
                  user_id: comment.user_id,
                  post_id: comment.post_id,
                  created_at: comment.created_at,
                  body: comment.body)
  end
end
