Rails.application.routes.draw do
  root 'players#index'
  resources :players, :matches

  post 'login' => 'players#login'
  get 'logout' => 'players#logout'

  namespace 'api' do
    jsonapi_resources :players
    jsonapi_resources :matches
  end
end
