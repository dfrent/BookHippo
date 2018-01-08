Rails.application.routes.draw do

  root 'books#index'

  get 'login' => 'sessions#new', :as => :login

  delete 'logout' => 'sessions#destroy', :as => :logout

  resources :reading_lists
  resources :genres, only: [:index, :show]
  resources :users
  resources :books, only: [:index, :show, :edit, :update] do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :sessions, only: [:create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
