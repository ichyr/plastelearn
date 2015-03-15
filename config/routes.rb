Rails.application.routes.draw do

  get 'user_cabinet', to: 'user_cabinet#index'

  get 'user_cabinet/courses'

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  root to: 'courses#index'
  
  devise_for :users
  
  resources :comments

  resources :homeworks

  resources :parts

  resources :courses

  resources :users

  resources :ratings, only: :update

  get "admin/index"
  get "admin/courses"
  # namespace :admin do
  # 	get '/users', to: "admin#index"
  # end
  
end
