Rails.application.routes.draw do
  get 'votes/create'
  get '/auth/github', as: 'github_login'
  get '/auth/:provider/callback', to: 'users#create'
  # get "/login", to: "users#login_form", as: "login"
  # post "/login", to: "users#login"
  delete "/logout", to: "users#destroy", as: "logout"
  root 'homepages#index'
  resources :works
  resources :users, only: [:index, :show]
end
