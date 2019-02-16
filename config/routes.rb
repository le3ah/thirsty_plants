Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/auth/google_oauth2', as: 'signin'
  get '/auth/google_oauth2/callback', to: 'sessions#create'

  get '/dashboard', to: "users#show"

  resources :gardens, except: [:index], shallow: true do

    resources :plants, only: [:new, :create, :destroy]
  end

  #Alter this below route to match the actual signout route, then alter navbar and navbar tests
  resources :signout, only: [:show]

  #Alter to match Ben's schedule path, then alter navbar and navbar test if applicable.
  resources :schedule, only: [:index]
end
