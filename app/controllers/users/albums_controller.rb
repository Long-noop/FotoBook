class Users::AlbumsController < ApplicationController
  before_action :authenticate_user!, except: [ :feed ]
  before_action :set_album, only: [ :show, :edit, :update, :destroy ]
  before_action :set_feed_albums, only: [ :feed ]
  before_action :set_discovery_albums, only: [ :discovery ]

  def index
    @albums =Album.where(mode: :public_mode)
    @tab = "album"
  end

  def feed
    @tab = "album"
  end

  def discovery
    @tab = "album"
  end

  def show
    @photos = @album.photos
    render partial: "modal", locals: { album: @album, photos: @photos }
  end

  def close_modal
      render turbo_stream: turbo_stream.update("album_modal", "")
  end

  def new
    @album = current_user.albums.build
  end

  def create
    @album = current_user.albums.build(album_params)

    if @album.save
      attach_photos_to_album(@album, params[:album][:photos])
      redirect_to users_profiles_path, notice: "Album created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @album.update(album_params)
      if params[:album][:deleted_photo_ids].present?
        Photo.where(id: params[:album][:deleted_photo_ids]).destroy_all
      end

      attach_photos_to_album(@album, params[:album][:photos])
      redirect_to users_profiles_path, notice: "Album updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @album.destroy
    redirect_to users_profiles_path, notice: "Album deleted successfully."
  end

  private

    def set_album
      @album = Album.find(params[:id])
    end

    def set_feed_albums
      if user_signed_in?
        followed_users = current_user.followings
        @feed_albums = Album.where(user: followed_users + [ current_user ], mode: :public_mode)
      else
        @feed_albums = Album.where(mode: :public_mode)
      end
    end

    def set_discovery_albums
      followed_users = current_user.followings
      @discovery_albums = Album.where(mode: :public_mode).where.not(user: followed_users + [ current_user ])
    end

    def album_params
      params.require(:album).permit(:title, :description, :mode)
    end

    def attach_photos_to_album(album, uploaded_photos)
      return unless uploaded_photos.present?

      count = album.photos.count
      valid_photos = uploaded_photos.reject(&:blank?)

      valid_photos.each do |uploaded_file|
        photo = current_user.photos.create(
          featured_image: uploaded_file,
          title: "#{album.title}_Img_#{count}",
          mode: album.mode
        )

        if photo.persisted?
          album.photos << photo
        else
          Rails.logger.warn "Photo save error: #{photo.errors.full_messages.join(', ')}"
        end

        count += 1
      end
    end
end
