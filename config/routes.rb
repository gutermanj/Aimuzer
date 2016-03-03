Rails.application.routes.draw do
   

  root 'discover#index'

  get 'discover/index'

  get '/stream' => 'discover#stream'

  devise_for :users

get '/soundcloud/connect',    :to => 'soundcloud#connect'
get 'soundcloud/connected', to: 'soundcloud#connected'
get 'logout', to: 'soundcloud#destroy', as: 'logout'
get '/soundcloud/new' => 'soundcloud#new'
post '/users/soundcloud' => 'soundcloud#save_soundcloud_user'

post 'users/:id/tag/:id' => 'users#add_tag'
  
get 'users/:id/likes' => 'tracks#likes'

resources :users do

	resources :tracks
  member do
      get :following, :followers
    end

  resources :playlists, only: [:new, :create, :show, :index]
  
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

  get 'welcome/search' => 'welcome#search'




  # match 'users/:id' => 'users#show', via: :get
  # or 
  # get 'users/:id' => 'users#show'
  # or
  



end
