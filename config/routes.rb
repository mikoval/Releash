Rails.application.routes.draw do
  get 'login/home'

  get 'login/help'

  resources :users
  root 'login#home'
end