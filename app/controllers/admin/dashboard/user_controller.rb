class Admin::Dashboard::UserController < Admin::BaseController
  before_action :set_user, only: [ :edit, :update, :destroy ]

  def index
    @users = User.order(created_at: :desc).page(params[:page]).per(10)
  end

  def edit; end

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

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :status, :avatar)
  end
end
