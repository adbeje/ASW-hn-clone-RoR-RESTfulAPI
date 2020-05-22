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
    post '/contribucions' => 'api/contribucions#create'
    put '/contribucions/vote/:id' => 'api/contribucions#vote'
    put '/contribucions/downvote/:id' => 'api/contribucions#downvote'
    put '/contribucions/edit/:id' => 'api/contribucions#edit'
    delete '/contribucions/:id' => 'api/contribucions#delete'

    get '/users/:id' => 'api/users#show'
    post '/users/email/' => 'api/users#showbyemail'
    post '/users/' =>'api/users#create'
    put '/users/:id' => 'api/users#edit'

    
    get '/comments/:id' => 'api/comments#show'
    get '/comments' => 'api/comments#showall'
    get '/comments/users/:id' => 'api/comments#fromuser'
    get '/comments/contribucions/:id' => 'api/comments#fromcontribucion'
    get '/comments/upvoted/users/:id' => 'api/comments#upvotedbyuser'
    post'/comments/contribucions/:id'=> 'api/comments#postcomment'
    put '/comments/edit/:id' => 'api/comments#edit'
    put '/comments/vote/:id' => 'api/comments#vote'
    put '/comments/downvote/:id' => 'api/comments#downvote'
    delete '/comments/:id' => 'api/comments#delete'


    
    get '/replies/:id' => 'api/replies#show'
    get '/replies' => 'api/replies#showall'
    get '/replies/users/:id' => 'api/replies#fromuser'
    get '/replies/upvoted/users/:id' => 'api/replies#upvotedbyuser'
    get '/replies/comments/:id' => 'api/replies#fromcomment'
    post'/replies/comments/:id' => 'api/replies#postreply'
    put '/replies/vote/:id' => 'api/replies#vote'
    put '/replies/downvote/:id' => 'api/replies#downvote'
    put '/replies/edit/:id' => 'api/replies#edit'
    delete '/replies/:id' => 'api/replies#delete'
    


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
