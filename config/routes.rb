Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/auth/google_oauth2', as: 'signin'
  get '/auth/google_oauth2/callback', to: 'sessions#create'

  get '/dashboard', to: "users#show"
  resources :gardens, only: [:new, :create, :show, :edit, :update], shallow: true do
    resources :plants, only: [:new, :create]
  end
end
