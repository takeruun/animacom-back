class V1::Posts::ShowController < ApplicationController
  def show
    @post = Post.find_by(id: params[:id])

    render 'v1/posts/show', formats: :json
  end
end
