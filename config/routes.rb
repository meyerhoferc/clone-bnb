Rails.application.routes.draw do

  root "home#index"
  resources :listings, only: [:show, :index]
  get "dashboard", to: "dashboard#show"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"

  put "update_host", to: "users#update"

  ## started users/:id/messages + /trips + /reservations + /listings blind
  resources :users, only: [:new, :create, :edit, :update] do
    resources :messages
    resources :trips
    #only if they are a host?#
    resources :reservations
    resources :listings     #, only: [:create, :show, :new, :create :destroy]
  end

end
