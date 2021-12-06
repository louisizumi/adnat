Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "organisations#index"
  devise_for :users
  resources :organisations, except: %i[new] do
    resources :employments, only: %i[create]
    resources :shifts, only: %i[create]
  end
  resources :employments, only: %i[destroy]
  resources :shifts, only: %i[update destroy]
end
