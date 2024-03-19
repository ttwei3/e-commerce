Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :products

  get '/static_pages/:identifier', to: 'static_pages#show', as: :static_page

  namespace :admin do
    resources :static_pages
  end

  root 'products#index'

  resources :categories do
    resources :products, only: [:index]
  end
end
