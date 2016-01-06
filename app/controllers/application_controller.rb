class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= Player.find(session[:player_id]) if session[:player_id]
  end
  helper_method :current_user

  def current_user_is_admin
    current_user && current_user.is_admin
  end
  helper_method :current_user_is_admin

end
