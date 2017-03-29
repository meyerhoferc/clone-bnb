Rails.application.routes.draw do
  root "home#index"
  resources :listings, only: [:show, :index]
  resources :users, only: [:new, :create]
  get "dashboard", to: "dashboard#show"

end
