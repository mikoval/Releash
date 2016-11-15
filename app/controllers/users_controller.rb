class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:create,:new]
  def show
    @user = User.find(params[:id])
    
  end

  def new
    @user = User.new
    render :layout => 'login'
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to iShelter!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
