Rails.application.routes.draw do
  devise_for :org_users, controllers: {
    registrations: 'org_users/registrations',
    invitations:   'org_users/invitations'
  }

  namespace :organization do
    get '/', to: 'dashboard#index', as: :root
    get 'edit', to: 'dashboard#edit'
    patch 'update', to: 'dashboard#update'

    resources :user_roles
    resources :users
    resources :contents
  end

  root to: "organization/dashboard#index"
  resources :un_authorized, only: [:index]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
