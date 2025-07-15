class Admin::Dashboard::UserController < ApplicationController
    before_action :authenticate_admin!
  def index
    # @users = User.all
    @users = User.order(created_at: :desc).page(params[:page]).per(10)
  end

  private
  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Unauthorized!!!"
    end
  end
end
