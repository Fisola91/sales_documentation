Rails.application.routes.draw do
  resources :orders, only: %i(index new create show)
  # get "public/index"

  root to: "orders#index"
  # root to: "users#index"
end
