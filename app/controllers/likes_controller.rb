class LikesController < ApplicationController
before_action :set_like, only: [:edit, :update, :index, :destory]
  def index
    @user = User.all
    @likes = Like.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @liked_posts = @user.liked_posts
  end
  

  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    redirect_to posts_path
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
    redirect_to posts_path
  end

  private
    def set_like
      @post = Post.find(params[:post_id])
    end
end
