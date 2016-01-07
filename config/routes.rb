Rails.application.routes.draw do
  root 'players#index'
  resources :players, :matches

  post 'login' => 'players#login'
  get 'logout' => 'players#logout'

  scope 'api', module: 'api' do
    jsonapi_resources :players
  end
end
