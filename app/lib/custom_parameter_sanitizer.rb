class CustomParameterSanitizer < Devise::ParameterSanitizer
  private

  def auth_params
    default_params.permit(auth: [:email, :password])
  end

  def sign_in
    auth_params[:auth] || {}
  end
end