class WaitingListController < ApplicationController
  before_filter :set_application

  def show
    unless [2, 4].any? {|code| code == @application.status}
      redirect_to dashboard_url
    end

    if @application.status == 4
      render 'show_accepted' and return
    end
  end

  def update
    # Check if current user is invited to waiting list
    redirect_to dashboard_url unless @application.status == 2

    # Change application status
    @application.status = params[:commit] == 'Yes' ? 4 : 0
    @application.save

    # If reply is no, deactivate user
    unless params[:commit] == 'Yes'
      current_user.active = false
      current_user.save

      redirect_to destroy_user_session_url and return
    end

    # Finished, send to dashboard
    redirect_to dashboard_url
  end

  private
    def set_application
      @application = current_user.workshop_application
    end
end