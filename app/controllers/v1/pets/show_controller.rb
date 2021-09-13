class V1::Pets::ShowController < ApplicationController
  def show
    @pet = Pet.find_by(id: params[:id])

    render 'v1/users/pets/show', formats: :json
  end
end