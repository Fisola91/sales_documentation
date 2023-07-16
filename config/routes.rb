Rails.application.routes.draw do
  resources :orders, only: %i(new create show)
  # get "public/index"

  root to: "orders#index"
  # root to: "users#index"
end
