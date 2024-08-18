Rails.application.routes.draw do
  require "sidekiq/web"

  devise_for :users
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  resources :documents, only: %i[new create]
  namespace :dashboard do
    resources :documents, only: %i[index show]
  end

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  get "/", to: 'dashboard/documents#index'
end
