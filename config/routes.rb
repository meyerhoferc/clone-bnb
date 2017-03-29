Rails.application.routes.draw do
<<<<<<< HEAD
  root "home#index"
  resources :listings, only: [:show, :index]
  resources :users, only: [:new, :create]
  get "dashboard", to: "dashboard#show"

=======
  get "dashboard", to: "dashboard#show"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"

  root "home#index"

  put "update_host", to: "users#update"
  resources :users, only: [:new, :create, :edit, :update]
>>>>>>> master
end
