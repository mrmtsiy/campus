Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'
    }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  root to: "home#index"
  resources :users do
    resource :follow
    resources :followings
    resources :followers
  end
  resources :posts do
    resources :comments, only: [:new, :create, :destroy]
    resources :likes, only: [:index, :show, :create, :destroy]
    collection do
      get 'search'
      get 'timeline'
    end
  end
  resources :contacts, only: [:new, :create] do
    get "/thanks", to: "contacts#thanks"
  end
end
