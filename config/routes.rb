Rails.application.routes.draw do
  scope :v1 do
    # route for registration
    devise_scope :user do
      post 'users/sign_up', to: 'users/registrations#create'
    end
    # route for login
    devise_scope :user do
      post 'auth/sign_in', to: 'users/sessions#create'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
