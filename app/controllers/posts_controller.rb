class PostsController < ApplicationController
  before_action :set_post, :authenticate_user!, only: [:show, :edit, :update, :destroy]
  before_action :owned_post, only: [:edit, :update, :destroy]
  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Your post has been created!"
      redirect_to posts_path @post
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
      redirect_to posts_path
    else
      flash.now[:danger] = "Oh no! Something went wrong."
      redirect_to :edit
    end
  end

  private

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
