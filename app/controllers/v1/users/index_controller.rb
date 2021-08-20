class V1::Users::IndexController < ApplicationController
  before_action :authenticate_v1_users_user!

  def index
    @user = current_v1_users_user
    @users = User.all.where.not(id: @user.id)

    render 'v1/users/index', formats: :json
  end
end