class UsersController < ApplicationController
before_action :correct_user, except: [:show, :index]
before_action :find_user, only: [:edit, :show]
  def index
    @users = User.all
  end

  def show
  
  end


  def edit

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
