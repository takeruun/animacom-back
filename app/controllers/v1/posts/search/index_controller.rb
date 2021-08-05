class V1::Posts::Search::IndexController < ApplicationController
  def index
    @posts = Post.joins(:category)

    @posts = @posts.where(category: {id: params[:category_id]}) if params[:category_id]
    
    @posts = @posts.where('title LIKE ? OR sub_title LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%") if params[:keyword]

    render 'v1/posts/index', formats: :json
  end
end