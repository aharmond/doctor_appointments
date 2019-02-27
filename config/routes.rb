Rails.application.routes.draw do
  root 'patients#home'

  devise_for :users
  
  resources :doctors do
    resources :patients, only: [:new, :create]
    resources :appointments
  end

  resources :patients do
    resources :appointments
  end

  get "home", to: 'patients#home', as: "home"
end
