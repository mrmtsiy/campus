Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
  root to: "home#index"
  resources :users do
    resource :follow
    resources :followings
    resources :followers
  end
  resources :posts do
    resources :likes, only: [:index, :show, :create, :destroy]
    collection do
      get 'search'
    end
  end
end
