
class Users::Photos::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_photo

  def create
    current_user.likes.create(likeable: @photo)
    @photo.reload
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to users_photos_path }
    end
  end

  def destroy
    current_user.likes.find_by(likeable: @photo)&.destroy
    @photo.reload
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to users_photos_path }
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end
end
