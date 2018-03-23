Rails.application.routes.draw do
  
  namespace :admin do
    resources :users
    resources :posts
    resources :admin_users

    root to: "users#index"
  end

  resources :posts do 
    member do 
      get :approve
    end
  end
  devise_for :users, skip: [:registrations]
  root to: 'static#home'

  resources :audit_logs, except: [:new, :edit, :destroy] do
    member do
      get :confirm
    end
  end
end
