Rails.application.routes.draw do
  root 'players#index'
  resources :players, :matches

  post 'login' => 'players#login'
  get 'logout' => 'players#logout'
end
