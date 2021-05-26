class PostsController < ApplicationController
before_action :find_post, only: [:edit, :update, :show, :destroy]

  def index
    @posts = Post.all.order(created_at: :DESC)
    time = Time.now
    
  end
  
  def show
    @user = @post.user
    @like = Like.new
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

  private

    def find_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :post_image, :user_id)
    end

    # def user
    #   return User.find_by(id: self.user_id)
    # end
end
