class V1::Users::Pets::IndexController < ApplicationController
  before_action :authenticate_v1_users_user!

  def index
    @pets = current_v1_users_user.pets

    render 'v1/users/pets/index', formats: :json
  end
end