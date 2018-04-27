Rails.application.routes.draw do


  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "articles#index"
  

  namespace :admin do 
    root "categories#index"
    resources :categories
    resources :users
  end

  resources :articles do
    resources :comments, only: [:create, :edit, :update, :destroy]
    member do 
      post :collect
      post :uncollect
    end 
    collection do 
      get :feeds
    end
  end
   
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :articles, only: [:index, :create, :show, :update, :destroy]
    end
  end



  resources :friend_requests2s
  resources :friendship2s
  resources :drafts
  resources :categories
  resources :users, only: [:show, :edit, :update, :posted_articles, :posted_drafts] do
    member do
      get :posted_articles
      get :posted_drafts
      get :posted_comments
      get :collected_articles
      get :friends
    end
    get '/friend_requests2s', to: 'friend_requests2s#index'
    get '/friends', to: 'friendship2s#index'
  end


end
