class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    session[:user_id] && User.find(session[:user_id])

    if session[:user_id]
      User.find(session[:user_id])
    else
      return nil
    end
  end

  def logged_in?
    current_user != nil
  end

  private
  def ensure_logged_in
    unless current_user
      flash[:alert] = "Please log in first."
      redirect_to login_url
    end
  end



end
