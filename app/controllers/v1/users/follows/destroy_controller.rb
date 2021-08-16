class V1::Users::Follows::DestroyController < ApplicationController
  before_action :authenticate_v1_users_user!

  def destroy
    ActiveRecord::Base.transaction do
      follow_user = User.find(params[:follow_id])
      current_v1_users_user.followings_relationships.find_by(follow_id: follow_user.id).destroy!
      @followings = current_v1_users_user.followings

      render 'v1/users/follows/followings', formats: :json
    rescue => e
      render json: { error: 'フォロー解除に失敗しました。', msg: "#{follow_user.name}はフォローしていません。" }
    end
  end
end