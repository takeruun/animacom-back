class V1::Users::IndexController < ApplicationController

  def index
    @users = User.all
    @user = current_v1_users_user

    render 'v1/users/index', formats: :json
  end
end