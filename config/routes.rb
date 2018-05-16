Rails.application.routes.draw do
  get 'students/index'

  devise_for :users

  resources :students

  post 'feed/:id', to: 'students#feed', as: :feed
  post 'sleep/:id', to: 'students#sleep', as: :sleep
  post 'bath/:id', to: 'students#bath', as: :bath
  post 'play/:id', to: 'students#play', as: :play

  root 'students#index'
end
