class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  config.time_zone = 'Eastern Time (US & Canada)'

  around_action :set_time_zone

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
      flash[:alert] = 'Please log in first.'
      redirect_to login_url
    end
  end

  def set_time_zone
    Time.use_zone('EST') { yield }
  end
end
