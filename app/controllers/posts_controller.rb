class PostsController < ApplicationController
before_action :find_post, only: [:edit, :update, :show, :destroy]
before_action :move_to_index, only: [:edit, :update, :destory]
  def index
    @posts = Post.all.order(created_at: :DESC)
    time = Time.now
    
  end
  
  def show
    @user = @post.user
    @like = Like.new
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: "投稿に成功しました"
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "投稿内容を変更しました"
    else
      render :edit
    end
    
  end

  def destroy
    @post.destroy
    redirect_to posts_path, alert: "投稿を削除しました"
  end

  def timeline
    @posts = Post.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :desc)
  end
  
  def search
    if params[:keyword].present?
      @posts = Post.where('title LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @posts = Post.all
    end
  end
  
  private

    def find_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :post_image, :user_id)
    end

    def move_to_index
      unless user_signed_in? == current_user
        redirect_to root_path, alert: "他のユーザーの投稿を編集することはできません"
    end
  end
    # def user
    #   return User.find_by(id: self.user_id)
    # end
end
