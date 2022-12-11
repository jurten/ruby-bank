Rails.application.routes.draw do
  resources :turns
  devise_for :users,  :path_prefix => 'mi'
  scope :users do
    get 'users/new_admin', to: 'users#admin_new', :as => 'new_admin'
    get 'users/new_staff', to: 'users#staff_new', :as => 'new_staff'
  end
  resources :users
  resources :schedules
  resources :branches
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
