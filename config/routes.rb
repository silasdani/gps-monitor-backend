Rails.application.routes.draw do
  # root 'users#index'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post 'validate_token', to: 'password_resets#validate_token'
  post 'reset_password', to: 'password_resets#update'
  post 'location', to: 'locations#add_location'
  post 'user_locations/:id', to: 'locations#get_user_locations'
  get 'locations', to: 'locations#locations'
  get 'tracks/my', to: 'tracks#my'
  get 'tracks/weekly_report', to: 'tracks#weekly_report'
  get 'ping', to: 'sessions#ping'

  resources :users, :tracks, :locations
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:create, :update]
  resources :account_activations, only: [:edit]
end
