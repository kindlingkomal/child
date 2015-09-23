Rails.application.routes.draw do
  devise_for :users
  root to: "pages#doc"
  get 'ragpicker/doc', to: 'pages#ragpicker'

  namespace :api, :defaults => {:format => :json} do
    resources :users, only: [:create] do
      put :update, on: :collection
    end

    resources :categories, only: :index
    resources :time_slots, only: :index
    resources :pick_ups, only: :create

    post 'authentication', to: 'authentication#create'
    get  'authentication/logout', to: 'authentication#logout'
  end

  namespace :api, :defaults => {:format => :json} do
    namespace :common, :defaults => {:format => :json} do
      resources :pick_ups, only: [:show, :index]
    end
  end

  namespace :api, :defaults => {:format => :json} do
    namespace :ragpicker, :defaults => {:format => :json} do
      resources :users, only: [:create] do
        put :update, on: :collection
      end

      resources :categories, only: :index
      resources :pick_ups, only: [] do
        get :accept, :cancel, on: :member
      end

      post 'authentication', to: 'authentication#create'
      get  'authentication/logout', to: 'authentication#logout'
    end
  end
end
