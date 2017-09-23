class CommentsController < ApplicationController
  before_action :set_post
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  def index
    @comments = @post.comments.order('created_at ASC')
    respond_to do |format|
      format.html { render layout: !request.xhr? }
    end
  end
  def new
    @comment = @post.comments.build
  end
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      create_notification @post, @comment
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:alert] = 'Failed to post comment!'
      render new
    end
  end
  def show
  end
  def edit
  end
  def update
  end
  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.user_id == current_user.id
      @comment.delete
      respond_to do |format|
        format.html { redirect_to root }
        format.js
      end
    end
  end
  private
  def comment_params
    params.require(:comment).permit(:content)
  end
  def set_post
    @post = Post.find(params[:post_id])
  end
  def set_comment
    @comment = @post.comments.find(params[:id])
  end
  def create_notification(post, comment)
    return if post.user.id == current_user.id
    Notification.create(user_id: post.user.id, 
                        notified_by_id: current_user.id, 
                        post_id: post.id, 
                        identifier: comment.id, 
                        notice_type: 'comment')
  end
end
