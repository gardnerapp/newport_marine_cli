Rails.application.routes.draw do
  resources :appointments
  namespace :api do
    resources :appointment, only: %i[create index]
  end
  namespace :api do
    resources :boats, only: :create
  end
  namespace :api do
    resources :users, only: %i[create show update]
  end
  resources :users
  post '/api/login', to: 'api/sessions#create'
  # TODO write test for api sessions, create, show, update
 

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
