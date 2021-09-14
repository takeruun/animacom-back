class V1::Pets::IndexController < ApplicationController
  def index
    @pets = Pet.all

    render 'v1/users/pets/index', formats: :json
  end
end