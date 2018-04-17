Rails.application.routes.draw do
  root to: "app#index"
  get '/admin' => 'app#admin'
  post '/admin' => 'app#admin'

  defaults format: :json do
    resources :api
  end
end
