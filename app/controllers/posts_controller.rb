class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if !@post.id.nil?
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

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def set_post
    @post = Post.find_by(params[:id])
  end
end
