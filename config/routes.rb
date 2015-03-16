Rails.application.routes.draw do

  get 'user_cabinet', to: 'user_cabinet#courses'

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  root to: 'courses#index'
  
  devise_for :users
  
  resources :comments

  resources :homeworks

  resources :parts

  resources :courses do
    get 'general_manage', on: :member
    get 'parts_manage', on: :member
    get 'statistics', on: :member
    get 'members', on: :member
    get 'enroll', on: :member
    post 'check_enroll', on: :member
  end

  resources :users

  resources :ratings, only: :update

  get "admin/index"
  get "admin/courses"
  # namespace :admin do
  # 	get '/users', to: "admin#index"
  # end
  
end
