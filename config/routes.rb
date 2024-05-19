Rails.application.routes.draw do
  namespace :api do
    namespace :v1  do
      devise_scope :user do
        # route for registration
        post 'users/signup', to: 'registrations#create'
        # route for login
        post 'auth/signin', to: 'sessions#create'
      end
      resources :contents
    end
  end

  devise_for :users
end
