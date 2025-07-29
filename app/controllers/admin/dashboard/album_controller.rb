class Admin::Dashboard::AlbumController < Admin::BaseController
  before_action :set_album, only: [ :edit, :update ]

  def index
    @albums = Album.order(created_at: :desc).page(params[:page]).per(12)
  end

  def edit; end

  def update
    if @album.update(album_params)
      attach_photos_to_album(@album, params[:album][:photos])
      redirect_to admin_dashboard_album_index_path, notice: "Album updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

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

  def set_album
    @album = Album.find(params[:id])
  end
end
