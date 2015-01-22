Rails.application.routes.draw do
  resources :comments

  resources :homeworks

  resources :parts

  resources :courses

  root to: 'courses#index'
  devise_for :users
  resources :users
end
