class V1::Posts::Reactions::Bests::Fav::IndexController < ApplicationController
  def index
    @posts = Post.kind_best_5(Reaction.kinds[:fav])

    render 'v1/posts/index', formats: :json
  end
end