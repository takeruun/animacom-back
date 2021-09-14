class V1::Users::Posts::IndexController < ApplicationController
  before_action :authenticate_v1_users_user!

  def index
    @posts = Post.all

    render 'v1/users/posts/index', formats: :json
  end
end
