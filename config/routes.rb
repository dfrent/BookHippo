Rails.application.routes.draw do
  root 'books#index'

  # BOOKS
  get 'recommendations' => 'books#recommendations'
  resources :books, only: %i[index show] do
    resources :reviews, only: %i[new create edit update destroy]
    resources :ratings, only: %i[update create]
  end

  # CONVERSATIONS
  resources :conversations, only: %i[index create] do
    resources :messages, only: %i[index new create]
  end

  # GENRES
  resources :genres, only: %i[index]

  # INTERESTS
  post 'users_genres' => 'interests#creation'

  # READING LISTS
  resources :reading_lists, only: %i[create]

  # SEARCH
  get 'search_for' => 'search_for#search_for', :as => :search_for

  # SESSIONS
  get 'login' => 'sessions#new', :as => :login
  delete 'logout' => 'sessions#destroy', :as => :logout
  resources :sessions, only: %i[create]

  # USERS
  get 'new_follow' => 'users#new_follow', :as => :new_follow
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: %i[create destroy]
end
