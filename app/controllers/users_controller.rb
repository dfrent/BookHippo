class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new

    @user.email = params[:user][:email]
    @user.username = params[:user][:username]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      # # Auto-login on succesful signup
      flash[:notice] = 'Account successfully created!'
      session[:user_id] = @user.id
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    @user.email = params[:user][:email]
    @user.username = params[:user][:username]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      # # Auto-login on succesful signup
      flash[:notice] = 'Account successfully created!'
      session[:user_id] = @user.id
      redirect_to user_url(current_user)
    else
      render :new
    end
  end

  def destroy
  end
end
