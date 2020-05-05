Rails.application.routes.draw do
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: "users/registrations" }
  resources :users, :only => [:show]
  
  scope "/api",defaults: {format: 'json'} do
    get '/contribucions/:id' =>'api/contribucions#show'
    get '/news' =>'api/contribucions#index_ordered'
    get '/asks'=>'api/contribucions#index_ask'
    get '/contribucions'=>'api/contribucions#index'
    get '/contribucions/users/:id' => 'api/contribucions#fromuser'
    get '/contribucions/upvoted/users/:id' => 'api/contribucions#upvotedbyuser'

    get '/users/:id' => 'api/users#show'

    
    get '/comments/:id' => 'api/comments#show'
    get '/comments' => 'api/comments#showall'
    get '/comments/users/:id' => 'api/comments#fromuser'
    get '/comments/contribucions/:id' => 'api/comments#fromcontribucion'
    get '/comments/upvoted/users/:id' => 'api/comments#upvotedbyuser'
    
    get '/replies/:id' => 'api/replies#show'
    get '/replies' => 'api/replies#showall'
    get '/replies/users/:id' => 'api/replies#fromuser'
    get '/replies/upvoted/users/:id' => 'api/replies#upvotedbyuser'
    get '/replies/comments/:id' => 'api/replies#fromcomment'
    


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
