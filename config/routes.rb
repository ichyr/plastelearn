Rails.application.routes.draw do

  root to: 'courses#index'
  
  devise_for :users
  
  resources :comments

  resources :homeworks

  resources :parts

  resources :courses

  resources :users

  resources :ratings, only: :update
  
end
