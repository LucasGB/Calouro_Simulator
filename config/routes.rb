Rails.application.routes.draw do
  get 'students/index'

  devise_for :users

  resources :students

  post 'feed/:id', to: 'students#feed', as: :feed

  root 'students#index'
end
