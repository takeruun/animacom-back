class V1::Posts::CreateController < ApplicationController
  before_action :authenticate_v1_users_user!

  def create
    @post = Post.new(
      user_id: current_v1_users_user.id,
      title: post_params[:title],
      sub_title: post_params[:sub_title],
      body: post_params[:body],      
      category_id: post_params[:category_id],
    )

    if @post.save
      render 'v1/posts/show', formats: :json
    else
      render json: { error: @post.errors.full_messages }
    end
  end

  private

  def post_params
    params.require(:post).permit(
      :title,
      :sub_title,
      :body,
      :category_id,
    )
  end
end
