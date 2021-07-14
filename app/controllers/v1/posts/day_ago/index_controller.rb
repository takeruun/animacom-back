class V1::Posts::DayAgo::IndexController < ApplicationController
  def index
    result = Rails.cache.read(params.to_json)
    return render json: result unless result.nil?

    @posts = Post.where(created_at: 1.day.ago.all_day)

    res = render 'v1/posts/index', formats: :json
    Rails.cache.write(params.to_json, res)
    res
  end
end
