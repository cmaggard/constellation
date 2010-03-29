# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  before_filter :require_login
  
  def require_login
    redirect_to :controller => '/login' unless logged_in?
  end
  
  helper_method :require_login
  
  def logged_in?
    session[:technician]
  end
  
  helper_method :logged_in?
  
  def clear_new_ticket_session!
    session[:customer] = nil
    session[:unit] = nil
  end
  
  helper_method :clear_new_ticket_session!
  
  def admin?
    redirect_to :controller => '/queue' unless session[:admin]
  end
  
  helper_method :admin?
  
  def user? 
  end
end