class V1::Users::Pets::DestroyController < ApplicationController
  before_action :authenticate_v1_users_user!

  def destroy
    pet = Pet.find_by(id: params[:id])

    if pet&.destroy
      render json: { status: 200 }
    else
      render json: { error: '削除に失敗しました。' }
    end
  end
end