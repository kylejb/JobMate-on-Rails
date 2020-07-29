Rails.application.routes.draw do
  resources :user_categories, only: :index
  resources :categories, only: [:show, :index]
  #resources :favorite_companies
  resources :companies, only: [:show, :index]
  resources :saved_postings, only: :index
  resources :postings, only: [:show, :index, :destroy]
  resources :users, except: [:index, :new, :create]

  root 'application#dashboard'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create', as: 'new_session'
  delete '/logout', to: 'sessions#destroy', as: 'delete_session'

  get '/signup', to: "users#new", as: "signup"
  post '/users', to: 'users#create', as: 'users'

# Form-tag to allow user to search for jobs
  get '/search', to: "searches#new", as: "new_search"

# Runs the scraper based on user's search parameters
  post '/search/result', to: "searches#create", as: "run_search"

  get '/search/result', to: "searches#show", as: "show_search"
end
