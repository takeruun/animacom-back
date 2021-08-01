class V1::Posts::Search::IndexController < ApplicationController
  def index
    @posts = Post.where('title LIKE ? OR sub_title LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    render 'v1/posts/index', formats: :json
  end
end