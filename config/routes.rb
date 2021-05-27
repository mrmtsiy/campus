Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
  root to: "home#index"
  resources :users
  resources :posts do
    resources :likes, only: [:index, :show, :create, :destroy]
    collection do
      get 'search'
    end
  end
end
