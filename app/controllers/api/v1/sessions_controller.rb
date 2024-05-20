class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json
  include SessionFix
  def create
    user = User.find_by(email: session_params[:email])

    if user && user.valid_password?(session_params[:password])
      sign_in(user)
      render json: {
        data: UserSerializer.new(current_user, {params: {token: request.env['warden-jwt_auth.token']}})
        .serializable_hash[:data]}, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private
  def session_params
    params.require(:auth).permit(:email, :password)
  end

  def respond_with(current_user, _opts = {})
    render json: {
            data: UserSerializer.new(current_user, {params: {token: request.env['warden-jwt_auth.token']}}).serializable_hash[:data]
    }, status: :ok
  end
end
