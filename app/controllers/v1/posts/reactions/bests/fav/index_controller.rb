class V1::Posts::Reactions::Bests::Fav::IndexController < ApplicationController
  before_action :authenticate_v1_users_user!

  def index
    @posts = Post.kind_best_5(Reaction.kinds[:fav])

    render 'v1/posts/index', formats: :json
  end
end