Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'delivery_informations', to: 'users/registrations#new_delivery_information'
    post 'delivery_informations', to: 'users/registrations#create_delivery_information'
  end

  root to: 'posts#index'
  get 'items', to: 'items#index'
  resources :items, only: [:index, :new, :create, :show]
end