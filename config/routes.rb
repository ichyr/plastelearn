Rails.application.routes.draw do
  resources :homeworks

  resources :parts

  resources :courses

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
