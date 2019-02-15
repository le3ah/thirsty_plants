Rails.application.routes.draw do
  root 'welcome#index'

  get '/auth/google_oauth2', as: 'signin'
  get '/auth/google_oauth2/callback', to: 'sessions#create'

  get '/dashboard', to: "users#show"

  resources :gardens, except: [:index], shallow: true do
    resources :plants, only: [:create, :edit, :update, :destroy, :new]
  end

end
