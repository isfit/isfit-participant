class Deadlines::InvitationController < ApplicationController
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
    redirect_to dashboard_url
  end

  def download
    if current_user.participant
      render pdf: 'invitation'
    else
      render nothing: true
    end
  end
end