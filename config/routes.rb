require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root 'welcome#index'
  get '/auth/google_oauth2', as: 'signin'
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'
  get '/invite/:garden_id', to: 'invite#show', as: 'invite'
  post '/invite/:garden_id', to: 'invite#create'


  get '/dashboard', to: "users#show"

  get '/caretaker/start/:garden_id', to: "caretaker/start#new", as: 'caretaker_start'
  delete '/caretaker/stop/:garden_id', to: "caretaker/stop#destroy", as: 'caretaker_stop'
  delete 'owner/caretaker/stop/:garden_id/:caretaker_id', to: "owner/caretaker/stop#destroy", as: 'owner_caretaker_stop'

  resources :gardens, shallow: true do
    resources :plants, except: [:index]
  end
  resources :waterings, only: [:update]
  resources :schedules, only: [:index]
  get 'settings', to: "settings#edit", as: "settings"
  patch 'settings/:id', to: "settings#update", as: "update_settings"
  namespace :admin do
    get '/dashboard', to: "users#index"
  end
end
