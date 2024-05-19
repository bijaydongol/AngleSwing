class Api::V1::SessionsController < Devise::SessionsController
  before_action :configure_permitted_parameters, on: :create
  respond_to :json

  private

  def respond_with(current_user, _opts = {})
    render json: {
            data: UserSerializer.new(current_user, {params: {token: request.env['warden-jwt_auth.token']}}).serializable_hash[:data]
    }, status: :ok
  end
end
