Rails.application.routes.draw do
  devise_for :users
  
  resources :doctors
  resources :patients do
    resources :appointments
  end
end
