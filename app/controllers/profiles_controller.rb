class ProfilesController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  def show
    @posts = @user.posts
  end

  def edit
    unless current_user == @user
      flash[:alert] = "Can't edit other users!"
      redirect_to root_path
    end
  end

  def update
    if @user.update(profile_params)
      flash[:success] = "Your profile has been updated!"
      redirect_to profile_path(@user.user_name)
    else
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end

  private

  def set_user
    @user = User.find_by(user_name: params[:user_name])
  end

  def profile_params
    params.require(:user).permit(:bio, :avatar)
  end
end
