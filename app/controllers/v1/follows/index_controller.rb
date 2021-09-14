class V1::Follows::IndexController < ApplicationController
  def followings
    @users = User.find_by(id: params[:user_id]).followings
    @user = current_v1_users_user

    render 'v1/users/index', formats: :json
  end

  def followers
    @users = User.find_by(id: params[:user_id]).followers
    @user = current_v1_users_user

    render 'v1/users/index', formats: :json
  end
end