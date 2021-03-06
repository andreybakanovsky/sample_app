Rails.application.routes.draw do
  root              'static_pages#home'
  get '/help',  to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/map', to: 'static_pages#map'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:edit, :create, :new, :update]
  resources :microposts, only:          [:create, :destroy]
  resources :relationships,  only: [:create, :destroy]
  
  # root 'application#hello' # controller/action
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
