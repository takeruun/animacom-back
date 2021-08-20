class V1::Users::Follows::IndexController < ApplicationController
  before_action :authenticate_v1_users_user!

  def index
    @user = current_v1_users_user
    @followings = @user.followings
    @followers = @user.followers

    render 'v1/users/follows/index', formats: :json
  end

  def followings
    @followings = current_v1_users_user.followings

    render 'v1/users/follows/followings', formats: :json
  end

  def followers
    @followers = current_v1_users_user.followers

    render 'v1/users/follows/followers', formats: :json
  end
end