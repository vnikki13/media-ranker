Rails.application.routes.draw do
  get 'votes/create'
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  root 'homepages#index'
  resources :works
  resources :users, only: [:index, :show]
end
