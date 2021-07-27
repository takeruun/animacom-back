class V1::Users::Posts::Reactions::IndexController < ApplicationController
  before_action :authenticate_v1_users_user!

  def index
    @posts = current_v1_users_user.posts.includes(:reactions).where(reactions: { kind: params[:kind]} )

    render 'v1/users/posts/index', formats: :json
  end
end