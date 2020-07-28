Rails.application.routes.draw do
  #resources :user_categories
  resources :categories, only: [:show, :index]
  #resources :favorite_companies
  resources :companies, only: [:show, :index]
  #resources :saved_postings
  resources :postings, only: [:show, :index, :destroy]
  resources :users, except: :index

  get 'users/:id/query', to: 'postings#query_results', as: 'query_results'
  get '/search', to: "search#new"
end
