class Admin::Dashboard::PhotoController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_photo, only: [ :edit, :update ]
  def index
    @photos = Photo.order(created_at: :desc).page(params[:page]).per(12)
  end

  def edit
  end

  def update
    if @photo.update(photo_params)
      redirect_to users_profile_path, notice: "Photo updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Unauthorized!!!"
    end
  end

  def set_photo
    photos = Photo.all
    @photo = photos.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:title, :description, :featured_image, :mode)
  end
end
