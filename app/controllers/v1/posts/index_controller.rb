class V1::Posts::IndexController < ApplicationController
  def index
    @posts = Posts.all

    render 'v1/posts/index'
  end
end
