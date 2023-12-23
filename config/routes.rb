Rails.application.routes.draw do
  get "prototype", to: "public#index"
  devise_for :users
  resources :orders, except: %i(show)
  resources :sales_per_day, only: %i(index)

  root "orders#index"
end
