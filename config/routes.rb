Rails.application.routes.draw do
  get "prototype", to: "public#index"

  resources :orders, except: %i(show)
  resources :sales_per_day, only: %i(index)

  root "orders#index"
end
