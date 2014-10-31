class Deadlines::InvitationController < ApplicationController
  def show
  end

  def update
  end

  def download
    if current_user.participant
      render pdf: 'invitation'
    else
      render nothing: true
    end
  end
end