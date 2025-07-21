class Admin::Dashboard::UserController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [ :edit, :update, :destroy ]

  def index
    @users = User.order(created_at: :desc).page(params[:page]).per(10)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_dashboard_user_index_path, notice: "User updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_dashboard_user_index_path, notice: "User deleted successfully."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Unauthorized!!!"
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :status, :avatar)
  end
end
