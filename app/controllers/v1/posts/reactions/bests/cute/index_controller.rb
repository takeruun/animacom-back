class V1::Posts::Reactions::Bests::Cute::IndexController < ApplicationController
  def index
    @posts = Post.kind_best_5(Reaction.kinds[:cute])

    render 'v1/posts/index', formats: :json
  end
end