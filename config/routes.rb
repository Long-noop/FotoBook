Rails.application.routes.draw do
  namespace :admin do
    get "dashboard/photo", to: "dashboard/photo#index"
    get "dashboard/album", to: "dashboard/album#index"
    get "dashboard/user", to: "dashboard/user#index"
    get "dashboard/user/:id/edit", to: "dashboard/user#edit", as: "edit_user"
  end
  devise_for :users

  root "homes#index"

  namespace :users do
    resources :profiles

    resources :photos do
      collection do
        get :feed
        get :discovery
      end
      resource :like, only: [ :create, :destroy ], module: :photos
    end

    resources :albums do
      collection do
        get :feed
        get :discovery
      end
      resource :like, only: [ :create, :destroy ], module: :albums
    end

    resource :follows, only: [ :create, :destroy ]
  end
end
