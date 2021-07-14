class V1::Posts::DestroyController < ApplicationController
  before_action :authenticate_v1_users_user!

  def destroy
    post = Post.find(params[:id])
    render json: { status: 403, error: '削除に失敗しました。', msg: '投稿の権限がありません。' } if post.user_id != current_v1_users_user.id

    if post.destroy
      render json: { status: 200 }
    end
  end
end