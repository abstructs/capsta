class CommentsController < ApplicationController
  before_action :set_post

  def index
    @comments = @post.comments.all
  end

  def show
  end

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to :back
      flash[:success] = "Comment has been successfully posted"
    else
      flash.now[:alert] = "Comment could not be posted"
      redirect_to root_path
    end
  end

  def destroy
    @post.comments.find_by(id: params[:id]).destroy
    flash[:success] =  "Comment has been successfully deleted"
    redirect_to root_path
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
