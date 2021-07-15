class V1::Posts::Latest::IndexController < ApplicationController
  def index
    @posts = Post.where(created_at: Time.current.all_day)

    render 'v1/posts/index', formats: :json
  end
end
