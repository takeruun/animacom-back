class V1::Users::Follows::CreateController < ApplicationController
  before_action :authenticate_v1_users_user!

  def create
    ActiveRecord::Base.transaction do
      follow_user = User.find(params[:follow_id])
      current_v1_users_user.followings_relationships.create!(follow_id: follow_user.id)
      @followings = current_v1_users_user.followings

      render 'v1/users/follows/followings', formats: :json
    rescue => e
      render json: { error: 'フォローに失敗しました。', msg: "#{follow_user.name}は既にフォローしています。" }
    end
  end
end