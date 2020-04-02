Rails.application.routes.draw do
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: "users/registrations" }
  resources :users, :only => [:show]
  resources :contribucions do
    member do
		  put 'point'
	  end
	end
  root 'contribucions#index'
  get  '/newest',     to: 'contribucions#index_ordered'
  get  '/submit',     to: 'contribucions#new'
  get  'users/id',    to: 'users#show'
end
