Rails.application.routes.draw do
  root 'players#index'
  resources :players, :matches

  post 'login' => 'players#login'
  get 'logout' => 'players#logout'

  namespace :api, defaults: { format: :json } do
    scope module: :v1 do
      resources :players, :matches
    end
  end
end
