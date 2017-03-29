Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  get "dashboard", to: "dashboard#show"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"

  root "home#index"
end
