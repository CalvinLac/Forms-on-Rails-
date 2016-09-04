class UsersController < ApplicationController
  
  before_action :require_login, :except => [:new, :create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]


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
    @user = User.new(whitelisted_user_params)
    if @user.save
      sign_in(@user)  # <<<<<<<
      flash[:success] = "Created new user!"
      redirect_to @user
    else
      flash.now[:error] = "Failed to Create User!"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update ({:username => params[:username]})
    @user.update ({:email => params[:email]})
    @user.update ({:password => params[:password]})
    redirect_to user_path
  end

  def destroy
    @user = User.find(params[:id])
    redirect_to users_path
    @user.destroy
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :email, :password_confirmation)
  end

end
