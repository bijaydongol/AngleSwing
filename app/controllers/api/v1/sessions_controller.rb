class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json

  def transform_auth_params
    if params[:auth]
      params[:user] = params.delete(:auth)
    end
  end

  private

  def respond_with(current_user, _opts = {})
    render json: {
            data: UserSerializer.new(current_user, {params: {token: request.env['warden-jwt_auth.token']}}).serializable_hash[:data]
    }, status: :ok
  end
end
