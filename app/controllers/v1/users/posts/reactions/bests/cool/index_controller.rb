class V1::Users::Posts::Reactions::Bests::Cool::IndexController < ApplicationController
  before_action :authenticate_v1_users_user!

  def index
    @posts = Post.kind_best_5(Reaction.kinds[:cool])

    render 'v1/users/posts/index', formats: :json
  end
end