Rails.application.routes.draw do
  
  root 'static_pages#dashboard'

  get '/login', to: 'sessions#new', as: 'new_session'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'delete_session'

  get '/signup', to: 'users#new', as: 'new_user'
  post '/signup', to: 'users#create'

  #this path lets a user add/edit categories
  get '/categories/choose', to: "user_categories#choose_categories", as: "choose_categories"
  post '/categories/set', to: "user_categories#set_categories"

  #Posting.all has all postings. 
  #When you click 'search', you narrow it by titles and locations that match
  get '/postings/search', to: "postings#search", as: "search_postings"


  resources :user_categories, only: :index
  resources :categories, only: [:show, :index]
  resources :companies, only: [:show, :index]
  resources :saved_postings, only: [:show, :index, :create]
  resources :postings, only: [:index, :show, :destroy]
  resources :users, except: [:index, :new, :create]
end
