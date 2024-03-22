Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :index]
      resources :stocks
      resources :items
      resources :departments
      resources :vendors
    end 
  end
  # root "posts#index"
end
