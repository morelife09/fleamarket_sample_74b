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
    get 'credit', to: 'users/credit'
    get 'logout', to: 'users/logout'
    get 'email', to: 'users/email'
    get 'owner', to: 'users/owner'
  end

  root to: 'items#index'
  resources :items, only: [:new, :create, :show, :destroy, :edit, :update] do
    member do
      get 'purchase'
      post 'pay'
      get 'complete'
      get 'search'
    end
    collection do
      get 'get_category', defaults: { format: 'json' }
    end
  end

  resources :credit_cards, only: [:new, :create, :index, :destroy]
end
