Rails.application.routes.draw do
  root 'players#index'
  resources :players, :matches

  get 'sign_in' => 'players#sign_in'
  post 'login' => 'players#login'
  get 'logout' => 'players#logout'
end
