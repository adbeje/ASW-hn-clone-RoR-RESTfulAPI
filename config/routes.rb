Rails.application.routes.draw do
  resources :comments 
  resources :contribucions do
    member do
		  put 'point'
	  end
	end
  root 'contribucions#index'
  get  '/newest',    to: 'contribucions#index_ordered'
  get  '/submit',    to: 'contribucions#new'
  get  '/comments', to: 'comments#index'
end
