class V1::Users::Pets::ShowController < ApplicationController
  before_action :authenticate_v1_users_user!

  def show
    @pet = Pet.find_by(id: params[:id])

    render 'v1/users/pets/show', formats: :json
  end
end