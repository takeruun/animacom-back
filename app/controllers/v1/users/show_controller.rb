class V1::Users::ShowController < ApplicationController
  before_action :authenticate_v1_users_user!

  def show
    @user = current_v1_users_user

    render '/v1/users/show', formats: :json
  end
end