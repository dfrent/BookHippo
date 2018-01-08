Rails.application.routes.draw do

  get 'login' => 'user_sessions#new', :as => :login

  delete 'logout' => 'user_sessions#destroy', :as => :logout

  resources :reading_lists
  resources :genres, only: [:index, :show]
  resources :users
  resources :books, only: [:index, :show, :edit, :update] do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :sessions, only: [:create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
