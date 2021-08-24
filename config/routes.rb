Rails.application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/help'
  get 'static_pages/about'
  # root 'application#hello' # controller/action
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
