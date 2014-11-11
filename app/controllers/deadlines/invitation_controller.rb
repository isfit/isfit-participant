class Deadlines::InvitationController < ApplicationController
  before_filter :restrict_access
  
  def show
  end

  def update
    @participant = current_user.participant

    if params[:commit] == 'Yes'
      @participant.accepted_invitation = 1
    else
      @participant.accepted_invitation = 0
    end

    @participant.save

    # Remove user if declined invitation
    unless params[:commit] == 'Yes'
      current_user.active = false
      current_user.save

      redirect_to destroy_user_session_url and return
    end

    redirect_to dashboard_url
  end

  def download
    if current_user.participant
      render pdf: 'invitation'
    else
      render nothing: true
    end
  end

  def download_financial
    if current_user.participant.granted_amount
      render pdf: 'isfit-funancial-aid'
    else
      render nothing: true
    end
  end

  private 
    def restrict_access
      unless current_user.role == 'participant'
        redirect_to dashboard_url, alert: "You don't have the permission to access that page."
      end
    end
end