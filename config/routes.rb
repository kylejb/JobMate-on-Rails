Rails.application.routes.draw do
  
  root 'static_pages#dashboard'

  get '/login', to: 'sessions#new', as: 'new_session'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'delete_session'

  get '/signup', to: 'users#new', as: 'new_user'
  post '/signup', to: 'users#create'
  patch '/signup', to: 'users#update'

  #this path lets a user add/edit categories
  # get '/categories/choose', to: "user_categories#choose_categories", as: "choose_categories"
  get '/category/choose', to: "users#choose_category", as: "choose_category"
  patch '/category/set', to: "users#assign_category", as: "set_category"

  #Posting.all has all postings. 
  #When you click 'search', you narrow it by titles and locations that match
  get '/postings/search', to: "postings#search", as: "search_postings"
  get '/postings/search/keyword', to: "postings#search_results" , as: "display_postings"
  post '/postings/search/reset', to: "postings#restart_search", as: "restart_search"
  get '/postings/search/experience' , to: 'postings#search_by_experience', as: "experience_search"

  resources :user_categories, only: :index
  resources :categories, only: [:show, :index]
  resources :companies, only: [:show, :index]
  resources :saved_postings, only: [:show, :index, :create]
  resources :postings, only: [:index, :show, :destroy]
  resources :users, except: [:index, :new, :update, :create]
end
