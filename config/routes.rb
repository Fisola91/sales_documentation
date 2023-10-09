Rails.application.routes.draw do
  get "prototype", to: "public#index"

  resources :orders, only: %i(index create edit update)

  root "orders#index"
end
