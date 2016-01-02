Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { registrations: 'user/registrations', sessions: 'user/sessions'}
  root to: "homepage#index"
  get 'terms-conditions', to: 'homepage#terms'

  namespace :user do
    resources :pick_ups, only: [:new, :create] do
      get :summary, on: :member
      get :summary, on: :collection
    end
    get '/profile', to: 'profile#show'
    get 'profile/edit',to: 'profile#edit'
    patch 'profile', to: 'profile#update'
  end
  get 'user/categories',to: 'categories#index'

  namespace :picker do
    devise_for :users, :controllers => { registrations: 'picker/registrations', sessions: 'picker/sessions'}
  end

  get :about_us, to: "homepage#about"
  get :become_partner, to: "homepage#become_partner"

  get 'api', to: 'pages#doc'

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
    post '/user/resendpwd', to: 'authentication#resendpwd'
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
          get :canceled
          get :picked
        end
      end

      get '/profile', to: 'profile#show'
      put '/profile', to: 'profile#update'

      post '/device/register', to: 'profile#device'
      post '/signup', to: 'sessions#create'
      post '/signin', to: 'sessions#signin'

      post '/rates', to: 'rates#create'

    end

    get '/picker/categories', to: 'categories#index'
    get '/picker/time_slots', to: 'time_slots#index'

    #post '/picker/signup', to: 'users#create'
    #post '/picker/signin', to: 'authentication#create'
    get '/picker/logout', to: 'authentication#logout'
    post '/picker/friends/invite', to: 'users#invite'
    post '/picker/resendpwd', to: 'authentication#resendpwd'

  end

  #namespace :api, :defaults => {:format => :json} do
  #  resources :users, only: [:create] do
  #    put :update, on: :collection
  #    post :invite, on: :collection
  #  end

  #  resources :categories, only: :index
  #  resources :rates, only: :create
  #  resources :time_slots, only: :index
  #  resources :pick_ups, only: :create

  #  post 'authentication', to: 'authentication#create'
  #  get  'authentication/logout', to: 'authentication#logout'
  #end

  #namespace :api, :defaults => {:format => :json} do
  #  namespace :common, :defaults => {:format => :json} do
  #    resources :pick_ups, only: [:show, :index]
  #    resources :users, only: [] do
  #      post :gcm_registration, on: :collection
  #    end
  #  end
  #end

  #namespace :api, :defaults => {:format => :json} do
  #  namespace :ragpicker, :defaults => {:format => :json} do
  #    resources :users, only: [:create] do
  #      put :update, on: :collection
  #    end

  #    resources :categories, only: :index
  #    resources :rates, only: :create

  #    resources :pick_ups, only: [] do
  #      get :accept, :cancel, :reject, on: :member
  #      post :proceed, on: :member
  #      post :add_customer, on: :collection
  #    end

  #    post 'authentication', to: 'authentication#create'
  #    get  'authentication/logout', to: 'authentication#logout'
  #  end
  #end
end
