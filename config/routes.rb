Rails.application.routes.draw do

  resources :listings, only: [:show, :index]
end
