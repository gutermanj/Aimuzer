Rails.application.routes.draw do
  get 'soundcloud/connect'

  get 'soundcloud/connected'

  get 'soundcloud/destroy'

  get 'relationships/new'

  get 'relationships/create'

  devise_for :users
 

get '/soundcloud/connect',    :to => 'soundcloud#connect'
get 'soundcloud/connected', to: 'soundcloud#connected'
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
