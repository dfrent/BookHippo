class UsersController < ApplicationController
  before_action :ensure_logged_in, except: %i[new create]

  READING_PROGRESS_STATUSES = %w[want_to_read currently_reading finished_reading].freeze

  def show
    @user = User.find(params[:id])
    @user_reading_lists = reading_lists_by_status
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # # Auto-login on succesful signup
      flash[:alert] = 'Account successfully created!'
      set_session
      redirect_to genres_url
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)

      # # Auto-login on succesful signup
      flash[:notice] = 'Account successfully updated!'
      set_session
      redirect_to user_url(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = 'You have successfully deleted your account'
    redirect_to books_url
  end

  def following
    @user  = User.find(params[:id])
    @title = "#{@user.username.capitalize} is following..."
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @title = "#{@user.username.capitalize}'s Followers"
    @users = @user.followers
    render 'show_follow'
  end

  def new_follow
    @user = current_user
    @users = User.users_to_follow(10, @user)
  end

  private

  def user_params
    user = params[:user]
    {
      email: user[:email],
      username: user[:username],
      password: user[:password],
      password_confirmation: user[:password_confirmation]
    }
  end

  def set_session
    session[:user_id] = @user.id
    cookies[:user_id] = @user.id
  end

  def reading_lists_by_status
    READING_PROGRESS_STATUSES.each_with_object({}) do |status, lists|
      lists[status] = @user.reading_lists.where(read_status: status)
    end
  end
end
