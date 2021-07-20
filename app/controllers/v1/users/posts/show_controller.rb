class V1::Users::Posts::ShowController < ApplicationController
  before_action :authenticate_v1_users_user!

  def show
    @post = Post.find_by(id: params[:id])

    render 'v1/users/posts/show', formats: :json
  end
end
