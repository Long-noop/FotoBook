module Users
  class PhotosController < ApplicationController
    before_action :authenticate_user!, except: [ :feed ]
    before_action :set_photo, only: [ :show, :edit, :update, :destroy ]
    before_action :set_feed_photos, only: [ :feed ]
    before_action :set_discovery_photos, only: [ :discovery ]

    def index
      @photos = Photo.where(mode: :public_mode)
      @tab = "photo"
    end

    def feed
      @tab = "photo"
    end

    def discovery
      @tab = "photo"
    end

    def show
      render partial: "modal", locals: { photo: @photo }
    end

    def new
      @photo = current_user.photos.build
    end

    def create
      @photo = current_user.photos.build(photo_params)
      if @photo.save
        redirect_to users_profile_path, notice: "Photo created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @photo.update(photo_params)
        redirect_to users_profile_path, notice: "Photo updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @photo.destroy
      redirect_to users_profile_path, notice: "Photo deleted."
    end

    private
      def set_photo
        followed_users = current_user.followings
        photos = Photo.where(user: followed_users + [ current_user ], mode: :public_mode)
        @photo = photos.find(params[:id])
      end

      def set_feed_photos
        if user_signed_in?
          followed_users = current_user.followings
          @feed_photos = Photo.where(user: followed_users + [ current_user ], mode: :public_mode)
        else
          @feed_photos = Photo.where(mode: :public_mode)
        end
      end

      def set_discovery_photos
        followed_users = current_user.followings
        @discovery_photos = Photo.where(mode: :public_mode).where.not(user: followed_users + [ current_user ])
      end

      def photo_params
        params.require(:photo).permit(:title, :description, :featured_image, :mode)
      end
  end
end
