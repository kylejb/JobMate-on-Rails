Rails.application.routes.draw do
  resources :user_categories, only: :index
  resources :categories, only: [:show, :index]
  #resources :favorite_companies
  resources :companies, only: [:show, :index]
  resources :saved_postings, only: [:index]
  resources :postings, only: [:index, :destroy]
  resources :users, except: [:index, :new, :create]

  root 'home#dashboard'

  get '/login', to: 'sessions#new', as: 'new_session'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'delete_session'

  get '/signup', to: 'users#new', as: 'new_user'
  post '/signup', to: 'users#create'

  #Posting.all has all postings. 
  #When you click 'search', you narrow it by titles and locations that match
  get '/postings/search', to: 'postings#search', as: 'search_postings'

  get '/postings/search_results', to: 'postings#search_results', as: 'display_postings'

# Form-tag to allow user to search for jobs
  get '/search/new', to: 'searches#new', as: 'new_search'

# Runs the scraper based on user's search parameters
  get '/search/result', to: 'searches#show', as: 'show_search'
  post '/search/result', to: 'searches#create'

  
end
