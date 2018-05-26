class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id] # ||= retrieves from database only if @current_user is empty
  end

  def logged_in?
  	!!current_user #this means return true if you have a current user else return false.
  end

  def require_user
  	if !logged_in?
  		flash[:danger] = "you must be logged to to perform this action"
  		redirect_to root_path
  	end
  end

end
