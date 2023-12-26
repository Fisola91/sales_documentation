Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get "prototype", to: "public#index"
  resources :orders, except: %i(show)
  resources :sales_per_day, only: %i(index)

  root "pages#home"
end
