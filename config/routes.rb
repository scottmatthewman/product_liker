Rails.application.routes.draw do
  resources :products, only: [:index]
  resources :likes, only: [:create]

  root 'products#index'
end
