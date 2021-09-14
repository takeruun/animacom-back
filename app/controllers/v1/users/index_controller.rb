class V1::Users::IndexController < ApplicationController
  before_action :authenticate_v1_users_user!

  def index
    @user = current_v1_users_user
    @users = User.all.where.not(id: @user.id)

    render 'v1/users/index', formats: :json
  end
  
  def pets
    @pets = User.find_by(id: params[:user_id]).pets

    render 'v1/users/pets/index', formats: :json
  end

  def posts
    @posts = User.find_by(id: params[:user_id]).posts

    render 'v1/users/posts/index', formats: :json
  end
end