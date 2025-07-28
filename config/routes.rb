Rails.application.routes.draw do
  namespace :admin do
    namespace :dashboard do
      resources :user, only: [ :index, :edit, :update, :destroy ]
      resources :photo, only: [ :index, :edit, :update, :destroy ]
      resources :album, only: [ :index, :edit, :update, :destroy ]
    end
  end

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  # root "homes#index"
  root "users/photos#index"

  namespace :users do
    resources :profiles

    resources :photos do
      collection do
        get :feed
        get :discovery
        get :close_modal
      end
      resource :like, only: [ :create, :destroy ], module: :photos
    end

    resources :albums do
      collection do
        get :feed
        get :discovery
        get :close_modal
      end
      resource :like, only: [ :create, :destroy ], module: :albums
    end

    # resource :follows, only: [ :create, :destroy ]
  end

  resources :users, only: [] do
    scope module: :users do
      member do
        post :follow, to: "follows#create", as: :follow
        delete :unfollow, to: "follows#destroy", as: :unfollow
      end
    end
  end
end
