class V1::Users::Auth::SessionsController < DeviseTokenAuth::SessionsController

  private

  def render_create_success
    resource_data = resource_data(resource_json: @resource.token_validation_response)
    user_id = resource_data["id"]
    @user = User.find(user_id)
    render 'v1/users/show', formats: :json
  end
end
