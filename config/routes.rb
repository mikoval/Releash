Rails.application.routes.draw do
  get 'users/new'

  get 'login/home'

  get 'login/help'
  get 'login/new'
  get  '/signup',  to: 'login#new'
  resources :users
  root 'login#home'
end