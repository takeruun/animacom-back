class V1::Users::Pets::CreateController < ApplicationController
  before_action :authenticate_v1_users_user!

  def create
    @pet = Pet.new(
      user: current_v1_users_user,
      name: pet_params[:name],
      age: pet_params[:age],
      gender: pet_params[:gender]&.to_i,
      image: pet_params[:image],
    )

    if @pet.save
      render 'v1/users/pets/show', formats: :json
    else
      render json: { error: 'ペット登録失敗しました。', msg: @pet.errors.full_messages }
    end
  end

  private

  def pet_params
    params.require(:pets).permit(
      :name,
      :age,
      :gender,
      :image
    )
  end
end
