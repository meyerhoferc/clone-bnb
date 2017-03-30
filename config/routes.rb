Rails.application.routes.draw do

  root "home#index"
  get "dashboard", to: "dashboard#show"
  
  resources :listings, only: [:show, :index] do
    resources :reservations, only: [:new, :create]
  end
  resources :reservations, only: [:show]

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"

  put "update_host", to: "users#update"
<<<<<<< HEAD

  ## started users/:id/messages + /trips + /reservations + /listings blind
  resources :users, only: [:new, :create, :edit, :update] do
    resources :messages
    resources :trips
    #only if they are a host?#
    resources :reservations
    resources :listings     #, only: [:create, :show, :new, :create :destroy]
  end

=======
  resources :users, only: [:new, :create, :edit, :update]
>>>>>>> 3cfbafab6d8d5923acd8e197567d1aef081e43a7
end
