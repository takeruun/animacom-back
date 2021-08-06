# frozen_string_literal: true

class CommentChannel < ApplicationCable::Channel
  def subscribed
    stream_from "comment_channel_#{params[:post_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def create(data)
    comment = Comment.create(
      user_id: data.fetch('user_id'),
      post_id: params[:post_id],
      body: data.fetch('body')
    )

  end
end
