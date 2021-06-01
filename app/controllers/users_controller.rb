class UsersController < ApplicationController
before_action :correct_user, except: [:show, :index]
before_action :find_user, only: [:edit, :show]
  def index
    @users = User.all
  end

  def show
    @posts = @user.posts.order(created_at: :DESC)
    @followings = @user.followings
    @followers = @user.followers
  end


  def edit
    
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: "アカウント情報を変更しました"
    else
      render :edit
    end
  end
  private
    def find_user
      @user = User.find(params[:id])
    end
    

    def user_params
      params.require(:user).permit(:username, :email, :profile, :profile_image)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to new_user_session_path unless @user == current_user
    end

end
