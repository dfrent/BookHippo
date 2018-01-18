class UsersController < ApplicationController
  before_action :ensure_logged_in, except: [:new, :create]

  def index
  end

  def show
    @user = User.find(params[:id])
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
      redirect_to genres_url
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    puts "************************"
    @user = current_user

    @user.email = params[:user][:email]
    @user.username = params[:user][:username]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]


    if @user.save
      puts "1 ************************"

      # # Auto-login on succesful signup
      flash[:notice] = 'Account successfully created!'
      session[:user_id] = @user.id
      redirect_to user_url(current_user)
    else
      puts "2 ************************"
      render :new
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully deleted your account"
    redirect_to books_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  def new_follow
    @user = current_user
    @users = User.users_to_follow(5, @user)
  end
end
