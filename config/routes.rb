Rails.application.routes.draw do
  get "prototype", to: "public#index"

  resources :orders, except: %i(show, edit) do
    member do
      post :edit
    end
  end

  root "orders#index"
end
