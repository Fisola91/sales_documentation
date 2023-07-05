Rails.application.routes.draw do
  get "public/index"

  root "public#index"
end
