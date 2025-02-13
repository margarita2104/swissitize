# config/routes.rb
Rails.application.routes.draw do
  # Authenticated vs. Unauthenticated Root
  authenticated :user do
    root 'users#show', as: :authenticated_root
  end

  unauthenticated do
    root 'home#index'
  end

  # Enable `/home` path for everyone
  get 'home', to: 'home#index', as: :home

  # Devise Routes
  devise_for :users

  # Users Routes
  resources :users, only: %i[index show new create edit update destroy]

  # Card Collections and Cards
  resources :card_collections do
    resources :cards
    member do
      get 'next_card', to: 'card_collections#show_next_card'
      get 'previous_card', to: 'card_collections#show_previous_card'
      get 'shuffle_cards', to: 'card_collections#shuffle_cards'
    end
  end

  # User Collection Relationships and Other Routes
  resources :user_collection_relationships

  # Health and PWA Routes
  get 'up' => 'rails/health#show', as: :rails_health_check
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest
end
