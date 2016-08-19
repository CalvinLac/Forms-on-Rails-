class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Congratulations on creating a new account!"
      redirect_to @user
    else
      flash[:error] = "Rats! There were errors when we tried to create your account..."
      render :new
    end
  end


  private
  def user_params
    params.permit(:username, :password, :email)
  end

end
