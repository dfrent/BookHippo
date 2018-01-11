Rails.application.routes.draw do

  root 'books#index'

  get "search_for" => "search_for#search_for", :as => :search_for

  get "new_follow" => "users#new_follow", :as => :new_follow

  get 'login' => 'sessions#new', :as => :login

  delete 'logout' => 'sessions#destroy', :as => :logout

  resources :reading_lists
  resources :genres, only: [:index, :show]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :books, only: [:index, :show, :edit, :update] do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :sessions, only: [:create]
  resources :relationships, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
