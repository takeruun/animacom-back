class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :snakeize_params

  protected

  # Snakeize JSON API request params
  def snakeize_params
    params.deep_snakeize!
  end
end
