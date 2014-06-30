class ApplicationController < ActionController::Base
  before_filter :authenticate_user!

  protect_from_forgery
 
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  private
    def access_denied
      if current_user
        flash[:alert] = 'You are not authorized to view this resource!'
        redirect_to root_path
      else
        flash[:warning] = 'Access denied. Try to log in first.'
        redirect_to login_path
      end
    end

    def check_if_can_manage_user
      user = User.find(params[:user_id] || params[:id])
      unless current_user == user or (can? :manage, User)
        redirect_to dashboard_url, alert: 'You are not authorized for accessing that user!'
      end
    end
end

