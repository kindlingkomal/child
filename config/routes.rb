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
    end

    namespace :picker do
      resources :pick_ups do
        member do
          get :cancel
          # post :reschedule
        end
        collection do
          get :pending
          get :accepted
        end
      end
    end
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
