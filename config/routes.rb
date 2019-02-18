Rails.application.routes.draw do
  root 'welcome#index'

  get '/auth/google_oauth2', as: 'signin'
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'

  get '/dashboard', to: "users#show"

  resources :gardens, shallow: true do
    resources :plants, only: [:create, :edit, :update, :destroy, :new]
  end
  resources :waterings, only: [:update]
  resources :schedules, only: [:index, :create]

  namespace :admin do
    get '/dashboard', to: "users#show"
    resources :users, only: [:index]
  end

end
