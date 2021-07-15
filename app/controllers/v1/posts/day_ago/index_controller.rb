class V1::Posts::DayAgo::IndexController < ApplicationController
  def index
    p params
    result = Rails.cache.read(params.to_json)
    return render json: result unless result.nil?

    @posts = Post.where(created_at: Time.current.yesterday.all_day)

    res = render 'v1/posts/index', formats: :json
    Rails.cache.write(params.to_json, res)
    res
  end
end
