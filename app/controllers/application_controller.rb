class ApplicationController < ActionController::Base
  after_filter :allow_iframe
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user  = User.first
    #@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  helper_method :current_user

  def require_login
    unless current_user
      #flash[:error] = "You must be logged in to access this section"
      redirect_to new_session_path
    end
  end


  def allow_iframe
    response.headers.delete "X-Frame-Options"
  end

end
