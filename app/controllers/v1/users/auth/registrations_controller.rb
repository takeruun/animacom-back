class V1::Users::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController

  def resource_errors
    p @resource.errors.to_hash.merge(full_messages: @resource.errors.full_messages)
  end

  private

  def sign_up_params
    params.permit(:name, :email, :nickname, :password, :password_confirmation)
  end
end
