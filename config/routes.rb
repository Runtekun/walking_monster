Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  devise_scope :user do
    get "users/profile", to: "devise/registrations#show", as: :user_profile
  end

  root "top_pages#top"

  resources :posts, only: %i[index new create show edit destroy update] do
    resources :comments, only: %i[create edit destroy], shallow: true
  end

  resources :destinations, only: %i[index create show edit update destroy] do
    member do
      post :complete_walk
    end
  end

  resources :user_monsters, only: %i[index new create]

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
