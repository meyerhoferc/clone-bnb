Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :listings do
        get 'find_all', to: "finder#index"
        get 'find', to: "finder#show"
        get 'most_visited', to: "visits#show"
        get 'most_visited_all', to: "visits#index"
        get 'listings_per_city', to: "cities#index"
      end
      namespace :cities do
        get 'most_visited', to: "finder#show"
      end
    end
  end

  namespace :admin do
    get 'dashboard', to: "dashboard#show"
    resources :users, only: [:index, :update]
    resources :listings, only: [:index, :show, :destroy]
    resources :reviews, only: [:index, :destroy]
  end

  root "home#index"

  get "listings_by_city", to: "home#show"

  get "dashboard", to: "dashboard#show"
  resources :codes, only: [:new, :create, :edit, :update]
  get 'reset_password', to: "codes#reset"
  patch 'reset_password', to: "codes#update_password"

  resources :listings do
    get "/reviews/new", to: "listings/reviews#new"
    post "/reviews/new", to: "listings/reviews#create"
  end

  resources :listings, only: [:show, :index] do
    resources :reservations, only: [:new, :create]
  end

  resources :reservations, only: [:show]

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"

  put "update_host", to: "users#update"
  post '/notification', to: 'notification#create'

  resources :users, only: [:new, :create, :edit, :update] do
    resources :reservations, only: [:index, :show, :new, :create, :update]
    resources :trips, only: [:index, :show]
    resources :reviews, only: [:index]
    get 'listings', to: 'user/listings#index'
  end

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :new, :create]
  end
end
