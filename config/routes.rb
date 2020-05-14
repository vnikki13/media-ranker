Rails.application.routes.draw do
  root 'homepages#index'
  resources :works
end
