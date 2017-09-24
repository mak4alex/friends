Rails.application.routes.draw do
  resources :users
  root 'home#dashboard'
  resources :tasks, except: [:show] do
    member do
      get 'start'
      get 'stop'
    end
  end
end
