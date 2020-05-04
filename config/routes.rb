Rails.application.routes.draw do
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: "users/registrations" }
  resources :users, :only => [:show]

scope "/api",defaults: {format: 'json'} do
  
  get '/contribucions' =>'api/contribucions#index'
  
end

  resources :contribucions do
    member do
      get "like"
      get "unlike"
    end
    post 'comment', on: :member
    resources :comments
  end
  
  resources :comments do
    member do
      get "like"
      get "unlike"
    end
	  resources :replies
	end
	
	resources :replies do
    member do
      get "like"
      get "unlike"
    end
	end

  
  root 'contribucions#index'
  get  '/newest',             to: 'contribucions#index_ordered'
  get  '/ask',                to: 'contribucions#index_ask'
  get  '/submit',             to: 'contribucions#new'
  get  '/user',               to: 'users#show'
  get  '/thread',             to: 'comments#index'
  get  '/upvotedsubmissions', to: 'contribucions#index_upvoted'
  get  '/upvotedcomments',    to: 'comments#index_upvoted'
  get  '/submissions',        to: 'contribucions#index_ordered'
end
