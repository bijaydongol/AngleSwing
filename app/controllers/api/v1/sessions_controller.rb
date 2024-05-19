class Api::V1::SessionsController < Devise::SessionsController
  before_action :configure_permitted_parameters, on: :create
  respond_to :json

  private

  def respond_with(current_user, _opts = {})
    render json: {
        data: { 
            user: UserSerializer.new(current_user).serializable_hash[:data][:attributes],
        }
    }, status: :ok
  end
end
