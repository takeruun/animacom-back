class V1::Posts::Reactions::CreateController < ApplicationController
  before_action :authenticate_v1_users_user!

  def create
    reaction = Reaction.new(
      kind: reaction_params[:kind].to_i,
      post_id: Post.find(params[:post_id]).id,
      user_id: current_v1_users_user.id,
    )


    if reaction.save
      render json: { status: 200 }
    else
      render json: { status: 400, error: I18n.t("enums.reaction.kind.#{Reaction.types.key(reaction_params[:kind])}") + "に失敗しました。", msg: reaction.errors.full_messages }
    end
  end

  private

  def reaction_params
    params.require(:reaction).permit(
      :kind,
    )
  end
end
