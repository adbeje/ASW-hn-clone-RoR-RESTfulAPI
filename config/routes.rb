Rails.application.routes.draw do
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: "users/registrations" }
  resources :users, :only => [:show]
  
  resources :replies

  resources :submissions do
     post 'comment', on: :member
   end

 resources :comments do
     post 'reply', on: :member
  end
  
  resources :contribucions do
    member do
		  put 'point'
	  end
	end
  root 'contribucions#index'
  get  '/newest',             to: 'contribucions#index_ordered'
  get  '/ask',                to: 'contribucions#index_ask'
  get  '/submit',             to: 'contribucions#new'
  get  '/user',               to: 'users#show'
  get  '/thread',             to: 'comments#index'
  get  '/submissions',        to: 'contribucions#index_ordered'
end
