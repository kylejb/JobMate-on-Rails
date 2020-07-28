Rails.application.routes.draw do
  #resources :user_categories
  resources :categories, only: [:show, :index]
  #resources :favorite_companies
  resources :companies, only: [:show, :index]
  #resources :saved_postings
  resources :postings, only: [:show, :index, :destroy]
  resources :users, except: [:index, :new, :create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create', as: 'new_session'
  delete '/logout', to: 'sessions#destroy', as: 'delete_session'

  get '/signup', to: "users#new", as: "signup"
  post '/users', to: 'users#create', as: 'users'


# Form-tag to allow user to search for jobs
  get '/search', to: "search#new", as: "new_search"
# Runs the scraper based on user's search parameters
  post '/search/result', to: "search#result", as: "result_search"


  
  
end
