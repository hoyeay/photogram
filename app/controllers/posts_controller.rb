class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = 'Your post has been created.'
      redirect_to posts_path
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
    if @post.update(post_params)
      flash[:success] = 'Post updated!'
      redirect_to(post_path(@post))
    else
      flash.now[:alert] = 'Update failed.'
      render :edit
    end
  end
  
  def destroy
    @post.destroy
    flash[:success] = 'Post deleted!'
    redirect_to posts_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:image, :caption)
  end
  
  def set_post
    @post = Post.find(params[:id])
  end
  
end
