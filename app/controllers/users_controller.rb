class UsersController < ApplicationController
  before_action :ensure_logged_in, except: [:new, :create]

  def index
  end

  def show
    @user                 = User.find(params[:id])
    # 3 variables to store the separate types of user reading lists
    @want_to_reads        = @user.reading_lists.where(read_status: "want_to_read")
    @currently_readings   = @user.reading_lists.where(read_status: "currently_reading")
    @finished_readings    = @user.reading_lists.where(read_status: "finished_reading")
    # Array of headers, for use in styling, class naming, and list selection
    @reading_list_headers = ["Want to Read", "Currently Reading", "Finished Reading"]
    # Hashes for the naming of classes and selection of lists
    @reading_list_classes = {
                           "Want to Read"      => "want_to_read",
                           "Currently Reading" => "currently_reading",
                           "Finished Reading"  => "finished_reading"
                            }
    @user_reading_lists   = {
                           "Want to Read"      => @want_to_reads,
                           "Currently Reading" => @currently_readings,
                           "Finished Reading"  => @finished_readings
                            }
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new

    # Selects all seeded (general public) book clubs, so that the new users begins subscribed to them
    @book_clubs = [BookClub.first, BookClub.second, BookClub.third, BookClub.find(4)]
    @user.email = params[:user][:email]
    @user.username = params[:user][:username]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      # # Auto-login on succesful signup
      flash[:alert] = 'Account successfully created!'
      session[:user_id] = @user.id
      cookies[:user_id] = @user.id

      # Subscribes new user to the general access book clubs
      @book_clubs.each do |club|
        @subscription = Subscription.new
        @subscription.user = @user
        @subscription.book_club = club
        @subscription.save
      end
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
    @user = current_user
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully deleted your account"
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
end
