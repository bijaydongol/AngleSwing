class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  include SessionFix

  private

  def sign_up_params
    params.transform_keys(&:underscore).permit(:first_name, :last_name, :email, :password, :country)
  end

  # format response to the desirable format
  def respond_with(current_user, _opts = {})
  # resource.persisted? checks whether the record is created/saved successfully or not
    if resource.persisted?
      render json: {
        status: {code: 200, message: 'Signed up successfully.'},
        # serialize the created date with user serializer
        data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        errors: current_user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end
end
