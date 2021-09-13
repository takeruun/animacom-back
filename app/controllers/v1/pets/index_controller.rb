class V1::Pets::IndexController < ApplicationController
  def index
    @pets = User.find_by(id: params[:user_id]).pets

    render 'v1/users/pets/index', formats: :json
  end
end