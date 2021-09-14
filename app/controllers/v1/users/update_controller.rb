class V1::Users::UpdateController < ApplicationController
  before_action :authenticate_v1_users_user!

  def update
    @user = current_v1_users_user

    @user.update(user_params)

    if @user.valid?
      render '/v1/users/show', formats: :json
    else
      render status: 400, json: { error: 'ユーザ情報更新失敗しました。', msg: @user.errors.full_messages }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :image, :introduction)
  end
end