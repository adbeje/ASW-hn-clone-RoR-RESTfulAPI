Rails.application.routes.draw do
  resources :contribucions do
    member do
		  put 'point'
	  end
	end
  root 'contribucions#index'
  get  '/newest',    to: 'contribucions#index_ordered'
  get  '/submit',    to: 'contribucions#new'
end
