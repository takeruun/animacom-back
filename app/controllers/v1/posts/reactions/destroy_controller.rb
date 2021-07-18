class V1::Posts::Reactions::DestroyController < ApplicationController
  before_action :authenticate_v1_users_user!

  def destroy
    reaction = Reaction.find(params[:id])

    if reaction.destroy
      render 'v1/posts/show', formats: :json
    else
      render json: { status: 400, error: I18n.t("enums.reaction.kind.#{reaction_params[:kind]}") + "取り消しに失敗しました。", msg: reaction.errors.full_messages }
    end
  end
end
