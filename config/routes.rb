Rails.application.routes.draw do

  root 'home#index'

  get 'login', to: 'sessions#login' , as: 'login'
  post 'verify-login', to: 'sessions#verify_login'
  get 'logout', to: 'sessions#destroy' , as: 'logout'

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/login'), via: [:get, :post]

end