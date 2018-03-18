Rails.application.routes.draw do
  root to: "app#index"

  defaults format: :json do
    resources :api
  end
end
