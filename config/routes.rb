Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home", as: "home"
  devise_for :users
  resources :organisations, except: %i[new] do
    patch "/join", to: "users#join"
  end
  patch "/leave", to: "users#leave", as: "organisation_leave"
  resources :shifts, only: %i[index create]
end
