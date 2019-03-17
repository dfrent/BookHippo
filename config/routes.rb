Rails.application.routes.draw do
  root 'books#index'

  get 'search_for' => 'search_for#search_for', :as => :search_for
  get 'new_follow' => 'users#new_follow', :as => :new_follow
  get 'recommendations' => 'books#recommendations'
  post 'users_genres' => 'interests#creation'
  get 'login' => 'sessions#new', :as => :login
  delete 'logout' => 'sessions#destroy', :as => :logout

  resources :reading_lists
  resources :genres, only: %i[index show]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :books, only: %i[index show] do
    resources :reviews, only: %i[new create edit update destroy]
    resources :ratings, only: %i[update show create]
  end
  resources :sessions, only: %i[create]
  resources :relationships, only: %i[create destroy]

  resources :conversations do
    resources :messages, only: %i[index new create]
  end
end
