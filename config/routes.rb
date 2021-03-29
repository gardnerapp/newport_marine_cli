Rails.application.routes.draw do
  root 'appointments#index'
  get '/privacy', to: 'helps#privacy'
  resources :helps, only: %i[index create]
  get '/help', to: 'helps#new'
  get 'help/success', to: 'helps#success'
  resources :appointments, only: %i[show edit update destroy]
  get '/unpaid', to: 'appointments#unpaid'
  get '/revenue', to: 'appointments#revenue'
  namespace :api do
    resources :users, only: %i[create show]
    resources :appointments, only: %i[create index]
    resources :boats, only: :create
    resources :users, only: :create
  end
  post 'api/login', to: 'api/sessions#create'
  resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :password_resets, only: %i[create edit update]
  get '/success', to: 'password_resets#success'
  get '/error', to: 'password_resets#error'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
