class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :get_post, only: [:show, :destroy, :edit, :update]
  def index
    @posts = Post.all
  end

  def my_post
    @posts = current_user.posts
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
    
  end

  def create
   @post = current_user.posts.new(post_params)
   respond_to do |format|
    if @post.save 
      format.html { redirect_to @post, notice: "Post created Succesfully" }
    else
      format.html { render :new }
    end
   end
  end

  def destroy
   if @post.destroy 
    flash[:notice] = "Post Destroyed Succesfully"
   else
    flash[:notice] = "Unable to destroy this Post"
   end
   redirect_to posts_path
  end

  def update
   respond_to do |format|
    if @post.update(post_params)
      format.html { redirect_to @post, notice: "Post Updated Succesfully" }
    else
      format.html { render :edit }
    end
   end
  end

  private

  def get_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:description, images:[])
  end
end
