Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  devise_for :users

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
  resources :users

  # Health and PWA Routes
  get 'up' => 'rails/health#show', as: :rails_health_check
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest
end
