Rails.application.routes.draw do


  root 'home#dashboard'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create', as: 'new_session'
  delete '/logout', to: 'sessions#destroy', as: 'delete_session'

  get '/signup', to: "users#new", as: "signup"
  post '/users', to: 'users#create', as: 'users'

  #this path lets a user add/edit categories
  get '/categories/choose', to: "user_categories#choose_categories", as: "choose_categories"
  post '/categories/set', to: "user_categories#set_categories"

  #Posting.all has all postings. 
  #When you click 'search', you narrow it by titles and locations that match
  get '/postings/search', to: "postings#search", as: "search_postings"

  get '/postings/search_results', to: "postings#search_results", as: "display_postings"



# # Form-tag to allow user to search for jobs
#   get '/search', to: "searches#new", as: "new_search"

# # Runs the scraper based on user's search parameters
#   post '/search/result', to: "searches#create", as: "run_search"

#   get '/search/result', to: "searches#show", as: "show_search"


  resources :user_categories, only: :index
  resources :categories, only: [:show, :index]
  #resources :favorite_companies
  resources :companies, only: [:show, :index]
  resources :saved_postings, only: [:show, :index, :create]
  resources :postings, only: [:index, :show, :destroy]
  resources :users, except: [:index, :new, :create]
end
