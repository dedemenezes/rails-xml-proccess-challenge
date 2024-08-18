Rails.application.routes.draw do
  devise_for :users
  get '/', to: 'dashboard/documents#index'

  require "sidekiq/web"
  mount Sidekiq::Web => '/sidekiq'

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :documents, only: %i[new create]
  namespace :dashboard do
    resources :documents, only: %i[index show]
  end
end
