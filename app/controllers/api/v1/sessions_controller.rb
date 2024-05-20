class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json
  before_action :configure_sign_in_params, only: [:create]

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    render json: {
      status: :ok,
      message: 'Signed in successfully.',
      user: UserSerializer.new(current_user).serializable_hash[:data][:attributes],
      token: request.env['warden-jwt_auth.token']
    }
  end

  private

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:auth])
  end

  def sign_in_params
    params.require(:auth).permit(:email, :password)
  end

  def respond_with(current_user, _opts = {})
    render json: {
            data: UserSerializer.new(current_user, {params: {token: request.env['warden-jwt_auth.token']}}).serializable_hash[:data]
    }, status: :ok
  end
end
