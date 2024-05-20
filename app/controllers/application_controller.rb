class ApplicationController < ActionController::API
  respond_to :json
  before_action :authenticate_user!, unless: :devise_controller?

  protected

  def authenticate_user!(options = {})
    if user_signed_in?
      super(options)
    else
      render json: { error: 'You need to sign in or sign up before continuing.' }, status: :unauthorized
    end
  end
end
