Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  
  root 'users#index'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users
  resources :tracks
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

end
