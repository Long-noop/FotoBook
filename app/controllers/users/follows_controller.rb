class Users::FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:following_id])
    current_user.followings << user unless current_user.followings.include?(user)
    redirect_to user
  end

  def destroy
    user = Follow.find(params[:id]).following
    current_user.followings.destroy(user)
    redirect_to user
  end
end
