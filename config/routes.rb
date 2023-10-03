Rails.application.routes.draw do
  get "prototype", to: "public#index"

  resources :orders, only: %i(index create)

  root "orders#index"
end
