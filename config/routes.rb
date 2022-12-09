Rails.application.routes.draw do
  devise_for :users,  :path_prefix => 'mi'
  resources :users
  resources :schedules
  resources :branches
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
