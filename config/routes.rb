Rails.application.routes.draw do
  devise_for :users
  root to: "pages#doc"
  namespace :api, :defaults => {:format => :json} do
    resources :users, only: [:create] do
      put :update, on: :collection
    end

    post 'authentication', to: 'authentication#create'
    get  'authentication/logout', to: 'authentication#logout'
  end
end
