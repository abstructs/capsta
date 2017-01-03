class PostsController < ApplicationController
  before_action :set_post, :authenticate_user!, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :owned_post, only: [:edit, :update, :destroy]
  def index
    if !current_user.nil?
      @posts = Post.of_followed_users(current_user.following).order('created_at DESC').page params[:page]
      respond_to do |format|
        format.html
        format.js
      end
    else
      flash[:alert] = "You have to log in before you can do that!"
      redirect_to new_user_session_path
    end
  end

  def browse
    @posts = Post.all.order('created_at DESC').page params[:page]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def like
    if @post.liked_by current_user
      create_notification(@post, current_user)
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  def unlike
    if current_user.voted_up_on? @post
      @post.unliked_by current_user

      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Your post has been created!"
      redirect_to post_path @post
    else
      flash.now[:alert] = "Your new post couldn't be created!"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.user_id == current_user.id
      @post.assign_attributes(post_params)
      if @post.changed?
        @post.save
        flash[:success] = "Post successfully updated!"
        redirect_to post_path(@post)
      else
        flash.now[:alert] = "Update failed. Please make a change."
        render :edit
      end
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "Post successfully deleted!"
      redirect_to root_path
    else
      flash.now[:danger] = "Oh no! Something went wrong."
      redirect_to :edit
    end
  end

  private

  def create_notification post, user
    return if post.user_id == current_user.id
    @notification = Notification.create(user_id: post.user_id,
                                       notified_by_id: user.id,
                                       post_id: post.id,
                                       read: false,
                                       identifier: post.id,
                                       notice_type: 'like')
  end

  def owned_post
    unless current_user == @post.user
      flash[:alert] = "That post does not belong to you!"
      redirect_to root_path
    end
  end

  def post_params
    params.require(:post).permit(:image, :caption, :user_id)
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end
end
