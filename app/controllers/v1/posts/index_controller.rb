class V1::Posts::IndexController < ApplicationController
  def index
    @posts = Post.all

    render 'v1/posts/index', formats: :json
  end
end
