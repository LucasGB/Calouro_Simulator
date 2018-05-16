Rails.application.routes.draw do
  get 'students/index'

  devise_for :users

  resources :students

  post 'feed/:id', to: 'students#feed', as: :feed
  post 'sleep/:id', to: 'students#sleep', as: :sleep
  post 'bath/:id', to: 'students#bath', as: :bath
  post 'exercise/:id', to: 'students#exercise', as: :exercise

  root 'students#index'
end
