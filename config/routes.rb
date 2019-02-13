Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/dashboard', to: "users#show"
  resources :gardens, only: [:new, :create, :show]
end
