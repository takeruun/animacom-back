class V1::Users::ShowController < ApplicationController
  before_action :authenticate_v1_users_user!

  def show
    @user = User.find(params[:user_id])
    @current_user = current_v1_users_user

    render '/v1/users/show', formats: :json
  end

  def my_page
    @user = current_v1_users_user

    render '/v1/users/show', formats: :json
  end
end