class CommentsController < ApplicationController

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_path(@post)
    else
      @post_new = Post.new
      @comments = @post.comments
      redirect_to new_post_comment_path, alert: "コメントを入力してください(1~100文字以内)"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to request.referer
  end

  private
    def comment_params
      params.require(:comment).permit(:comment)
    end
    
end
