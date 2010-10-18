class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from 'Acl9::AccessDenied', :with => :access_denied
  
  private

  def access_denied
    if current_user
      flash[:alert] = "You are not authorized to view this resource!"
      render :template => 'home/index'
    else
      flash[:warning] = 'Access denied. Try to log in first.'
      redirect_to login_path
    end
  end    

  def render_to_pdf(options = nil)
    data = render_to_string(options)
    pdf = PDF::HTMLDoc.new
    pdf.set_option :bodycolor, :white
    pdf.set_option :toc, false
    pdf.set_option :portrait, true
    pdf.set_option :links, false
    pdf.set_option :webpage, true
    pdf.set_option :left, '2cm'
    pdf.set_option :right, '2cm'
    pdf << data
    pdf.generate
  end
end

