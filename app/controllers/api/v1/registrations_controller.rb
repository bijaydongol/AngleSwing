class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

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

# protected
#   # Tell Devise which mapping to use
#   def after_sign_up_path_for(resource)
#     '/api/v1/users/sign_up'
#   end
end
