Rails.application.routes.draw do

  resources :flux_comments
  get 'password_resets/new'
  get 'password_resets/edit'

  get 'sessions/new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'users/new'

  # static pages
  resources :static_pages
  get 'about' => 'static_pages#about'
  get 'help'  => 'static_pages#help'

  # fluxes
  resources :fluxes do
    member do
      get :comments
    end
  end
  # fluxes comments
  resource :flux_comments

  # users
  resources :users do
    member do
      get :following, :followers, :userProfile, :cats
    end
  end
  get 'signup' => 'users#new'
  # for application client register
  post 'register_new_user' => 'users#register_new_user' # TODO: delete this api
  # root page
  root 'static_pages#home'

  # account active
  resources :account_activations, only: [:edit]
  # password resets
  resources :password_resets,     only: [:new, :create, :edit, :update]

  # tokens
  resources :tokens, only: [:index, :destroy]
  post 'request_new_token' => 'tokens#request_new_token'
  get 'check_token' => 'tokens#check_token'

  # relationships
  resources :relationships, only: [:create, :destroy]

  # cats
  resources :cats do
    member do
      post :setLocation
    end
  end
  get 'catsModelKeys' => 'cats#modelKeys'
  get 'nearbyCat' => 'cats#nearby'

  # error pages
  get 'error' => 'error#show'

end
