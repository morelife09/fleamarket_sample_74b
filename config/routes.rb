Rails.application.routes.draw do

  root 'users#show'
  resources :users, only: [:show]
  devise_for :users
  root 'users#mypage'
  get 'mypage', to: 'users#mypage'
  root 'items#index'
  get 'items', to: 'items#index'

end
