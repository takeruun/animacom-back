class V1::Categories::IndexController < ApplicationController
  def index
    #result = Rails.cache.read(params.to_json)
    #return render json: result unless result.nil?

    @categories = Category.all

    res = render 'v1/categories/index', formats: :json
    #Rails.cache.write(params.to_json, res)
    res
  end
end