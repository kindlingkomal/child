Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root to: "pages#doc"
  get 'ragpicker/doc', to: 'pages#ragpicker'

  namespace :api, defaults: {format: :json} do
    namespace :user do
      resources :pick_ups do
        member do
          get :cancel
          # post :reschedule
        end
        collection do
          get :upcoming
          get :history
        end
      end
      get '/profile', to: 'profile#show'
      put '/profile', to: 'profile#update'
      post '/device/register', to: 'profile#device'
      post '/rates', to: 'rates#create'
    end
    get '/user/categories', to: 'categories#index'
    get '/user/time_slots', to: 'time_slots#index'
    post '/user/friends/invite', to: 'users#invite'
    post '/user/signup', to: 'users#create'
    post '/user/signin', to: 'authentication#create'
    get '/user/logout', to: 'authentication#logout'
  end

  namespace :api, defaults: {format: :json} do
    namespace :picker do
      resources :pick_ups do
        member do
          post :cancel
          post :proceed
          get :accept
          get :reject
        end
        collection do
          get :pending
          get :accepted
        end
      end

      get '/profile', to: 'profile#show'
      put '/profile', to: 'profile#update'

      post '/device/register', to: 'profile#device'
      post '/signup', to: 'sessions#create'
      post '/signin', to: 'sessions#signin'

    end

    post '/picker/rates', to: 'rates#create'
    get '/picker/categories', to: 'categories#index'
    get '/picker/time_slots', to: 'time_slots#index'

    post '/picker/signup', to: 'users#create'
    post '/picker/signin', to: 'authentication#create'
    get '/picker/logout', to: 'authentication#logout'
    post '/picker/friends/invite', to: 'users#invite'

  end

  namespace :api, :defaults => {:format => :json} do
    resources :users, only: [:create] do
      put :update, on: :collection
      post :invite, on: :collection
    end

    resources :categories, only: :index
    resources :rates, only: :create
    resources :time_slots, only: :index
    resources :pick_ups, only: :create

    post 'authentication', to: 'authentication#create'
    get  'authentication/logout', to: 'authentication#logout'
  end

  namespace :api, :defaults => {:format => :json} do
    namespace :common, :defaults => {:format => :json} do
      resources :pick_ups, only: [:show, :index]
      resources :users, only: [] do
        post :gcm_registration, on: :collection
      end
    end
  end

  namespace :api, :defaults => {:format => :json} do
    namespace :ragpicker, :defaults => {:format => :json} do
      resources :users, only: [:create] do
        put :update, on: :collection
      end

      resources :categories, only: :index
      resources :rates, only: :create

      resources :pick_ups, only: [] do
        get :accept, :cancel, :reject, on: :member
        post :proceed, on: :member
        post :add_customer, on: :collection
      end

      post 'authentication', to: 'authentication#create'
      get  'authentication/logout', to: 'authentication#logout'
    end
  end
end
