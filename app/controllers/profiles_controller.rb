class ProfilesController < ApplicationController
  before_action :set_user, only: [:show, :edit]
  def show
    @posts = @user.posts
  end

  def edit
    unless current_user == @user
      flash[:alert] = "Can't edit other users!"
      redirect_to root_path
    end
  end

  private

  def set_user
    @user = User.find_by(user_name: params[:user_name])
  end
end
