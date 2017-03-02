class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new 
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      redirect_to posts_path 
    else 
      render 'new'
    end  
  end

  def show

  end

  def edit
  end

  def update
  end

  def destroy
    @post.destroy
    if @post.destroy
      redirect_to posts_path
    else
      render 'index'
    end
  end

  private 

    def find_post
      @post = Post.find(params[:id])
    end 

    def post_params
      params.require(:post).permit(:author, :title, :content)
    end
end
