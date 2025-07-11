Rails.application.routes.draw do
  namespace :admin do
    get "dashboard/photo", to: "dashboard/photo#index"
    get "dashboard/album", to: "dashboard/album#index"
    get "dashboard/user", to: "dashboard/user#index"
  end
  devise_for :users

  root "homes#index"

  namespace :users do
    resource :profile, only: [ :show, :edit, :update ]

    resources :photos do
      resource :like, only: [ :create, :destroy ], module: :photos
    end

    resources :albums do
      resource :like, only: [ :create, :destroy ], module: :albums
    end

    resource :follows, only: [ :create, :destroy ]
  end
end
