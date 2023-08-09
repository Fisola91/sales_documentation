Rails.application.routes.draw do
  get "public/index"

  root "public#index"

  get "demo", to: "demos#show"
  post "demo", to: "demos#update"
end
