Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'delivery_informations', to: 'users/registrations#new_delivery_information'
    post 'delivery_informations', to: 'users/registrations#create_delivery_information'
  end

  resources :users, only: :show do
    get 'credit', to: 'users#credit'
    get 'logout', to: 'users#logout'
  end

  root to: 'posts#index'
  resources :items, only: [:index, :new, :create, :show] do
    member do
      get 'purchase'
    end
    collection do
      get 'get_category', defaults: { format: 'json' }
    end
  end
end
