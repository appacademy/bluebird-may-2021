Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #Chirp Routes
  # get "/chirps", to: "chirps#index"
  # post "/chirps", to: "chirps#create"
  # get "/chirps/:id", to: "chirps#show"
  # patch "/chirps/:id", to: "chirps#update"
  # delete "/chirps/:id", to: "chirps#destroy"

  resources :chirps


end
