class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :country, :created_at, :updated_at

  attribute :name do |user|
    [user.first_name, user.last_name].join(' ')
  end

  attribute :token do |_user, params|
    params[:token]
  end
end
