class V1::Users::Posts::EditController < ApplicationController
  before_action :authenticate_v1_users_user!

  def edit
    @post = current_v1_users_user.posts.find_by(id: params[:id])

    @post.update(
      title: post_params[:title],
      sub_title: post_params[:sub_title],
      body: post_params[:body],      
      category_id: post_params[:category_id],
    )

    image_ids_not_delete = post_params[:images].map{|n| n[:id].to_i if n[:id].present? }.compact
    @post.images.where.not(id: image_ids_not_delete).destroy_all

    post_params[:images].each do |image|
      unless image[:id].present?
        @post.images.create(image: image[:file])
      end
    end

    if @post.valid?
      render 'v1/users/posts/show', formats: :json
    else
      render json: { error: '投稿編集失敗しました。', msg: @post.errors.full_messages }
    end
  end

  private

  def post_params
    params.require(:post).permit(
      :title,
      :sub_title,
      :body,
      :category_id,
      images: [
        :id,
        :file,
      ],
    )
  end
end
