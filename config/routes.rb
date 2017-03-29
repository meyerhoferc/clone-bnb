Rails.application.routes.draw do
  resources :users, only: [:new, :create, :edit, :update]
  get "dashboard", to: "dashboard#show"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"

  root "home#index"
end
