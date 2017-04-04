Rails.application.routes.draw do

  root "home#index"
  get "dashboard", to: "dashboard#show"

  resources :listings do
    #resources :reviews, only: [:index, :new, :create]
    get "/reviews/new", to: "listings/reviews#new"
    post "/reviews/new", to: "listings/reviews#create"
    # /listings/3/reviews/new
  end

  resources :listings, only: [:show, :index] do
    resources :reservations, only: [:new, :create]
  end


  resources :reservations, only: [:show]

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"

  put "update_host", to: "users#update"

  namespace :admin do
    get 'dashboard', to: "dashboard#show"
    resources :users, only: [:index, :update]
    resources :listings, only: [:index, :show, :destroy]
  end

  resources :users, only: [:new, :create, :edit, :update] do
    resources :reservations, only: [:index, :show, :new, :create, :update]
    resources :messages
    resources :trips, only: [:index, :show]
    resources :reviews, only: [:index]
    get 'listings', to: 'user/listings#index'
    get 'listings/:listing_id', to: 'user/listings#show', as: 'listing'
    get 'listings/:listing_id/edit', to: 'user/listings#edit', as: 'edit_listing'
  end

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :new, :create]
  end
end
