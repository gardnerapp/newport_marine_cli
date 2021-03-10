Rails.application.routes.draw do
  root 'appointments#index'
  resources :appointments, only: %i[show edit update destroy]
  get '/unpaid', to: 'appointments#unpaid'
  get '/revenue', to: 'appointments#revenue'
  namespace :api do
    resources :appointments, only: %i[create]
  end
  namespace :api do
    resources :boats, only: :create
  end
  namespace :api do
    resources :users, only: %i[create show]
  end
  resources :users
  post '/api/login', to: 'api/sessions#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
