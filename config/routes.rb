Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "articles#index"
  
  resources :articles do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  
  namespace :admin do 
    root "categories#index"
    resources :categories
    resources :users
  end


  resources :drafts
  resources :categories
  resources :users, only: [:show, :edit, :update, :posted_articles, :posted_drafts] do
    member do
      get :posted_articles
    end

    member do 
      get :posted_drafts
    end

    member do
      get :posted_comments
    end

  end


end
