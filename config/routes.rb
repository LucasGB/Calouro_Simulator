Rails.application.routes.draw do
  get 'students/index'

  devise_for :users

  resources :students

  get 'feed/:id', to: 'students#feed', as: :feed
  get 'sleep/:id', to: 'students#sleep', as: :sleep
  get 'bath/:id', to: 'students#bath', as: :bath
  get 'exercise/:id', to: 'students#exercise', as: :exercise
  get 'cure/:id', to: 'students#cure', as: :cure
  get 'study/:id', to: 'students#study', as: :study
  put 'convert_points/:id', to: 'students#convert_points', as: :convert_points

  get 'update/:id', to: 'students#update', as: :update

  get 'ranking', to: 'students#ranking', as: :ranking

  get 'play/:id', to: 'students#play', as: :play

  root 'students#index'
end
