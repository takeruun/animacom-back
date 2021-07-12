class V1::Posts::IndexController < ApplicationController
  def index
    result = Rails.cache.read(params.to_json)
    return render json: result unless result.nil?

    @posts = Post.all

    res = render 'v1/posts/index', formats: :json
    Rails.cache.write(params.to_json, res)
    res
  end
end
