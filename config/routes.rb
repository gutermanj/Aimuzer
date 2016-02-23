Rails.application.routes.draw do
  get 'relationships/new'

  get 'relationships/create'

  devise_for :users
 

get '/soundcloud/connect',    :to => 'soundcloud#connect'
get 'soundcloud/oauth-callback', to: 'soundcloud#connected'
get '/users/:id/likes' => 'tracks#likes'
get 'logout', to: 'soundcloud#destroy', as: 'logout'

resources :users do

	resources :tracks
  member do
      get :following, :followers
    end
  
	# post 'tracks' => 'tracks#create'
  
  end
  resources :relationships,       only: [:create, :destroy]

resources :tracks do
   member do
    post "like", to: "tracks#upvote"
    post "unlike", to: "tracks#unvote"
  end
end
 

  resources (:devise)
  get 'welcome/index'




  # match 'users/:id' => 'users#show', via: :get
  # or 
  # get 'users/:id' => 'users#show'
  # or
  


  root 'welcome#index'

end
