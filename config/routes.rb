Rails.application.routes.draw do
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
  end
end
