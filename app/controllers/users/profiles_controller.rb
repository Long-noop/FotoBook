class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [ :index, :show, :edit, :update, :destroy ]

  def index
    @users_follower = @user.followers
    @users_following = @user.followings
  end

  def show
    @another_user = User.find(params[:id])
  end

  def new
    @user = User.build
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "User created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_profile_path, notice: "Profile updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :avatar)
  end

  def set_profile
    @user = User.find_by(id: params[:id]) || current_user
  end
end
