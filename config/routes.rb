Rails.application.routes.draw do
 
 

get '/soundcloud/connect',    :to => 'soundcloud#connect'
get 'soundcloud/oauth-callback', to: 'soundcloud#connected'
get 'logout', to: 'soundcloud#destroy', as: 'logout'

  devise_for :users

  resources (:devise)
  get 'welcome/index'

  match 'users/:id' => 'users#show', via: :get
  # or 
  get 'users/:id' => 'users#show'
  # or
  resources :users, only: [:show]



  root 'welcome#index'

end
