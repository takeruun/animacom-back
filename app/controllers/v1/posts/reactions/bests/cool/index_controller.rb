class V1::Posts::Reactions::Bests::Cool::IndexController < ApplicationController
  def index
    @posts = Post.kind_best_5(Reaction.kinds[:cool])

    render 'v1/posts/index', formats: :json
  end
end