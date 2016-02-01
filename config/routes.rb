Rails.application.routes.draw do

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
  resources :flux_comments
  # fluxes likes
  resources :flux_likes, only: [:create, :destroy] do
    collection do
      delete 'cancel_like'
    end
  end

  # users
  resources :users do
    member do
      get :following, :followers, :userProfile, :cats
    end

    collection do
      put 'avatar'
      post 'update_information'
      get 'self_information'
      get 'self_following'
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
  resources :relationships, only: [:create, :destroy] do
    collection do
      delete 'unfollow'
    end
  end

  # cats
  resources :cats do
    member do
      post :setLocation
      post :update
    end
  end
  get 'catsModelKeys' => 'cats#modelKeys'
  get 'nearbyCat' => 'cats#nearby'

  # trends
  resources :trends, except: [:create, :edit, :update, :new, :show]

  # remote notification tokens
  resources :remote_notification_tokens, only: [:create, :destroy] do
    collection do
      delete 'break_token'
    end
  end

  # private messages
  resources :private_messages, except: [:edit, :destroy] do
    collection do
      get 'with_user/:id', to: :with_user
    end
  end

  # error pages
  get 'error' => 'error#show'

end
