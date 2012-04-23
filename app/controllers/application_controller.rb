class ApplicationController < ActionController::Base
  protect_from_forgery
  # rescue_from 'Acl9::AccessDenied', :with => :access_denied
  
  private

  def access_denied
    if current_user
      flash[:alert] = "You are not authorized to view this resource!"
      redirect_to root_path
    else
      flash[:warning] = 'Access denied. Try to log in first.'
      redirect_to login_path
    end
  end    

end

