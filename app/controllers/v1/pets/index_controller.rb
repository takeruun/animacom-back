class V1::Pets::IndexController < ApplicationController
  before_action :authenticate_v1_users_user!

  def index
    @pets = User.find_by(id: params[:user_id]).pets

    render 'v1/users/pets/index', formats: :json
  end
end