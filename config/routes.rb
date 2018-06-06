Rails.application.routes.draw do
  get 'students/index'

  devise_for :users

  resources :students

  get 'feed/:id', to: 'students#feed', as: :feed
  get 'sleep/:id', to: 'students#sleep', as: :sleep
  get 'bath/:id', to: 'students#bath', as: :bath
  get 'exercise/:id', to: 'students#exercise', as: :exercise

  get 'update/:id', to: 'students#update', as: :update

  get 'ranking', to: 'students#ranking', as: :ranking

  root 'students#index'
end
