class CommentsController < ApplicationController
  before_action :set_post

  def index
    @comments = @post.comments.order("created_at ASC")
    respond_to do |format|
      format.html { render layout: !request.xhr? }
    end
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
      # create_notification @post, @comment
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:alert] = "Check the comment form, something went wrong."
      render root_path
    end
  end

def destroy
  @comment = @post.comments.find(params[:id])

  if @comment.user_id == current_user.id
    @comment.delete
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
end

  private

  # def create_notification post, comment
  #   return if post_id == current_user.id
  #   @notification = Notification.build(user_id: post.user_id,
  #                                      notified_by_id: comment.user_id,
  #                                      post_id: post.id,
  #                                      comment_id: comment.id,
  #                                      notice_type: 'comment')
  # end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
