class Admin::Dashboard::PhotoController < ApplicationController
    before_action :authenticate_admin!
  def index
    @photos = Photo.order(created_at: :desc).page(params[:page]).per(12)
  end

  private
  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Unauthorized!!!"
    end
  end
end
