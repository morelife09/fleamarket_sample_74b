Rails.application.routes.draw do

  get 'users#show'
  resources :users, only: [:show]
  devise_for :users
  root 'items#index'
  get 'items', to: 'items#index'

end
