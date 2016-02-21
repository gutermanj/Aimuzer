Rails.application.routes.draw do
  get 'relationships/new'

  get 'relationships/create'

  devise_for :users
 

get '/soundcloud/connect',    :to => 'soundcloud#connect'
get 'soundcloud/oauth-callback', to: 'soundcloud#connected'
get 'logout', to: 'soundcloud#destroy', as: 'logout'

resources :users do

	resources :tracks
  member do
      get :following, :followers
    end

	# post 'tracks' => 'tracks#create'
  
  end
  resources :relationships,       only: [:create, :destroy]


 

  resources (:devise)
  get 'welcome/index'




  # match 'users/:id' => 'users#show', via: :get
  # or 
  # get 'users/:id' => 'users#show'
  # or
  


  root 'welcome#index'

end
