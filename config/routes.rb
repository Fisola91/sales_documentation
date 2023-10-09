Rails.application.routes.draw do
  get "prototype", to: "public#index"

  resources :orders, except: %i(show)

  root "orders#index"
end
