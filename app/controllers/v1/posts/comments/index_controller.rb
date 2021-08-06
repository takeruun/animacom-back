class V1::Posts::Comments::IndexController < ApplicationController
  def index
    @comments = Post.find(params[:post_id]).comments

    render 'v1/comments/index', formats: :json
  end
end