Rails.application.routes.draw do


  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  root to: 'courses#index'
  
  devise_for :users
  
  resources :comments

  resources :homeworks

  resources :parts do
    put 'move_status', on: :member
  end

  resources :courses do
    get 'general_manage', on: :member
    get 'parts_manage', on: :member
    get 'statistics', on: :member
    get 'report/:user_id', to: 'courses#report', as: "report", on: :member
    get 'members', on: :member
    get 'enroll', on: :member
    post 'check_enroll', on: :member
    put 'assign_user_as_course_teacher', on: :member
    delete 'delete_user_from_course', on: :member
  end

  get 'courses/:id/user_stats/:user_id', to: "courses#user_stats"

  resources :users

  resources :ratings, only: :update

  get "admin/index"
  get "admin/courses"

  get 'user_cabinet', to: 'user_cabinet#courses'
  get 'user_cabinet/courses_assisted', to: 'user_cabinet#courses_teacher'
  get 'user_cabinet/courses_own', to: 'user_cabinet#courses_owner'
end
