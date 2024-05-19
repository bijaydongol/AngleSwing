Rails.application.routes.draw do
  namespace :api do
    namespace :v1  do
      devise_scope :user do
        # route for registration
        post 'users/sign_up', to: 'registrations#create'
        # route for login
        post 'auth/sign_in', to: 'sessions#create'
      end
    end
  end

  devise_for :users
end
