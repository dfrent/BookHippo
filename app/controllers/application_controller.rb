class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    session[:user_id] && User.find(session[:user_id])

    if session[:user_id]
      User.find(session[:user_id])
    else
      return nil
    end
  end

  def ensure_logged_in
    unless current_user
      flash[:alert] = "Please log in"
      redirect_to login_url
    end
  end

  def search_for
    @user = User.all
    @books = []
    @isbn = result["book_details"][0]["primary_isbn10"]

    if params[:search]
    @user = user.search_for(params[:search])
      if @user.length > 0
        render
      else
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
  end

end
