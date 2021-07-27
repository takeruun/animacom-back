class V1::Posts::Reactions::Bests::Good::IndexController < ApplicationController
  def index
    @posts = Post.kind_best_5(Reaction.kinds[:good])

    render 'v1/posts/index', formats: :json
  end
end