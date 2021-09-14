class V1::Users::Posts::Reactions::CreateController < ApplicationController
  before_action :authenticate_v1_users_user!

  def create
    @post = Post.find(params[:post_id])

    reaction = Reaction.new(
      kind: reaction_params[:kind],
      post_id: @post.id,
      user_id: current_v1_users_user.id,
    )

    if reaction.save
      render 'v1/users/posts/show', formats: :json
    else
      error = I18n.t("enums.reaction.kind.#{reaction_params[:kind]}") + "に失敗しました。" 
      render status: 400, json: { error: error, msg: reaction.errors.full_messages }
    end
  end

  private

  def reaction_params
    params.require(:reaction).permit(
      :kind,
    )
  end
end
