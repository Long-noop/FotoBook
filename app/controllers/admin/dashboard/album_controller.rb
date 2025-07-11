class Admin::Dashboard::AlbumController < ApplicationController
    before_action :authenticate_admin!
  def index
    @albums= Album.all
  end

  private
  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Unauthorized!!!"
    end
  end
end
