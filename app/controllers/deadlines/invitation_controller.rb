class Deadlines::InvitationController < ApplicationController
  before_filter :restrict_access
  
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

  def download_lor_travel_support
    if current_user.participant
      render pdf: 'letter-of-recommendation-travel-support'
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