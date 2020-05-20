Rails.application.routes.draw do
  get 'votes/create'
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  root 'homepages#index'
  resources :works
  resources :users, only: [:index, :show]
end
