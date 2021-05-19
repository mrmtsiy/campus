class UsersController < ApplicationController
before_action :correct_user, except: [:show, :index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end


  private
    def user_params
      params.require(:user).permit(:username, :email, :profile, :profile_image)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to new_user_session_path unless @user == current_user
    end

end
