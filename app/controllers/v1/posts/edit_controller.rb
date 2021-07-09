class V1::Posts::EditController < ApplicationController
  before_action :authenticate_v1_users_user!

  def edit
    @post = current_v1_users_user.posts.find_by(id: params[:id])

    @post.update(
      title: post_params[:title],
      sub_title: post_params[:sub_title],
      body: post_params[:body],      
      category_id: post_params[:category_id],
    )

    if @post.valid?
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
      images: [],
    )
  end
end
