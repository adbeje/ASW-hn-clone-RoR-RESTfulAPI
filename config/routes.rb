Rails.application.routes.draw do
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: "users/registrations" }
  resources :users, :only => [:show]
  
  resources :comments 

  resources :contribucions do
    resources :comments
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
