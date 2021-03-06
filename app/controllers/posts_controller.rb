class PostsController < ApplicationController
before_action :find_post, only: [:edit, :update, :show, :destroy]
before_action :move_to_index, only: [:edit, :update, :destory]
  def index
    @posts = Post.page(params[:page]).per(42).order('created_at DESC')
    time = Time.now
    #タグの絞り込み
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}").page(params[:page]).per(42).order('created_at DESC')
    end
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
      flash.now[:alert] = "必須項目を記入して下さい"
      render :new
    end
  end

  def edit
    
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "投稿内容を変更しました"
    else
      flash.now[:alert] = "タイトルと内容を記入してください"
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
      params.require(:post).permit(:title, :content, :post_image, :user_id, :tag_list)
    end

    def move_to_index
      unless user_signed_in? && current_user
        redirect_to root_path, alert: "他のユーザーの投稿を編集することはできません"
    end
  end
    # def user
    #   return User.find_by(id: self.user_id)
    # end
end
