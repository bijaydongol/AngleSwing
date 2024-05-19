class ApplicationController < ActionController::API
  respond_to :json
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end

  def devise_parameter_sanitizer
    # overridden for only sesson controller
    # further for create action only you check use action_name == "create" 
    if resource_class == User && controller_name == "sessions"
      CustomParameterSanitizer.new(User, :user, params)
    else
      super # Use the default one for other Devise models (if any)
    end
  end

  def authenticate_user!(options = {})
    if user_signed_in?
      super(options)
    else
      render json: { error: 'You need to sign in or sign up before continuing.' }, status: :unauthorized
    end
  end
end
