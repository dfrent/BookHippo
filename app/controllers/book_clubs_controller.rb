class BookClubsController < ApplicationController
  before_action :can_user_access?, only: :show
  before_action :user_owner?, only: :edit

  def index
    @book_clubs = BookClub.all
  end

  def show
    @book_club = BookClub.find(params[:id])
    @book = @book_club.book
    @chat = Chat.new
    Rails.logger.info(@chat.errors.inspect)
    if request.xhr?
      render json: @chat.body
    end
  end

  def new
    @book_club = BookClub.new
  end

  def create
    @book_club = BookClub.new
    @subscription = Subscription.new

    @book_club.user = current_user
    @book_club.name = params[:book_club][:name]
    @book_club.book_id = params[:book_club][:book_id]
    @book_club.description = params[:book_club][:description]
    @book_club.goal = params[:book_club][:goal]

    if @book_club.save
      @subscription.book_club = @book_club
      @subscription.user = @book_club.user
      @subscription.save
      redirect_to book_club_url(@book_club)
    else
      render :new
    end
  end

  def edit
    @book_club = BookClub.find(params[:id])
  end

  def update
    @book_club = BookClub.find(params[:id])

    @book_club.name = params[:book_club][:name]
    @book_club.book_id = params[:book_club][:book_id]
    @book_club.description = params[:book_club][:description]
    @book_club.goal = params[:book_club][:goal]

    if @book_club.save
      redirect_to book_club_url(@book_club)
    else
      render :edit
    end
  end

  def invitations
    @user = current_user
    @book_club = BookClub.find(params[:book_club_id])
    @followers = current_user.followers
    @following = current_user.following
  end

  def destroy
  end

  private

  def chat_params
    params.require(:chat).permit(:body, :book_club_id)
  end

  def can_user_access?
    @book_club = BookClub.find(params[:id])
    @user = @book_club.user
    unless @book_club.users.include?(current_user)
      flash[:alert] = "Please ask #{@user.username} for an invitation first."
      redirect_to book_clubs_url
    end
  end

  def user_owner?
    @book_club = BookClub.find(params[:id])
    @user = @book_club.user
    if current_user != @user
      flash[:alert] = "Sorry, book club admin only."
      redirect_to book_clubs_url
    end
  end
end
