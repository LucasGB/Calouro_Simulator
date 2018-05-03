Rails.application.routes.draw do
  get 'students/index'

  devise_for :users

  resources :students

  root 'students#index'
end
