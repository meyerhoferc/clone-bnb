Rails.application.routes.draw do

  root "home#index"
  resources :listings, only: [:show, :index]
  get "dashboard", to: "dashboard#show"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"

  put "update_host", to: "users#update"
  resources :users, only: [:new, :create, :edit, :update]

end
