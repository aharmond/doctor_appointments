Rails.application.routes.draw do
  root 'patients#home'

  devise_for :users
  
  resources :doctors do
    resources :patients, only: [:new, :create]
    resources :appointments, only: [:new, :edit, :destroy]
  end

  resources :patients do
    resources :appointments, only: [:index, :edit, :destroy]
  end

  get "home", to: 'patients#home', as: "home"
end
