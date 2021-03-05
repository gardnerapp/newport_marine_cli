Rails.application.routes.draw do
  root 'application#home'
  resources :appointments, only: %i[show edit update destroy]
  namespace :api do
    resources :appointments, only: %i[create index]
  end
  namespace :api do
    resources :boats, only: :create
  end
  namespace :api do
    resources :users, only: :create
  end
  resources :users
  post '/api/login', to: 'api/sessions#create'
  resources :password_resets, only: %i[create edit update]
  get '/success', to: 'password_resets#success'
  get '/error', to: 'password_resets#error'

 

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
