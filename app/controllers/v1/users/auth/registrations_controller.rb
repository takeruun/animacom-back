class V1::Users::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController

  def resource_errors
    p @resource.errors.to_hash.merge(full_messages: @resource.errors.full_messages)
  end

  private

  def sign_up_params
    params.permit(:name, :email, :nickname, :image, :password, :password_confirmation, :introduction)
  end

  def render_create_success
    resource_data = resource_data(resource_json: @resource.token_validation_response)
    user_id = resource_data["id"]
    @user = User.find(user_id)
    render 'v1/users/show', formats: :json
  end
end
