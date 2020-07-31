Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'delivery_informations', to: 'users/registrations#new_delivery_information'
    post 'delivery_informations', to: 'users/registrations#create_delivery_information'
  end
  root to: 'posts#index'
  root to: 'items#index'
  get 'items', to: 'items#index'
  
end