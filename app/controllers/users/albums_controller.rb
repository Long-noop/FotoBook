class Users::AlbumsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_album, only: [ :show, :edit, :update ]
  def index
    @albums = Album.where(mode: :public_mode)
  end

  def show
    @album = current_user.albums
  end

  def new
    @album = current_user.albums.build
  end

  def create
    @album = current_user.albums.build(album_params)

    if @album.save
      if params[:album][:photos].present?
        count = 0

        valid_photos = params[:album][:photos].reject { |ph| ph.blank? }

        valid_photos.each do |uploaded_file|
          photo = current_user.photos.create(
            featured_image: uploaded_file,
            title: "#{@album.title}_Img_#{count}",
            mode: @album.mode
          )

          if photo.persisted?
            @album.photos << photo
          else
            Rails.logger.warn "Photo save error: #{photo.errors.full_messages.join(', ')}"
          end

          count += 1
        end
      end

      redirect_to users_profile_path, notice: "Album created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end


    def edit
    end

  def update
    if @album.update(album_params)
      redirect_to users_album_path(@album), notice: "Album updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_album
    @album = current_user.albums.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:title, :description, :mode)
  end
end
