Rails.application.routes.draw do

  get 'admin/index'

  get 'admin/courses'

  root to: 'courses#index'
  
  devise_for :users
  
  resources :comments

  resources :homeworks

  resources :parts

  resources :courses

  resources :users

  resources :ratings, only: :update

  namespace :admin do
  	get '\users', to: "admin#index"
  end
  
end
