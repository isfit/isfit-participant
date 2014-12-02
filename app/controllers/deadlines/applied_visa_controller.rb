class Deadlines::AppliedVisaController < ApplicationController
  before_filter :restrict_access
  
  def show
  end

  def update
    @participant = current_user.participant

    @participant.applied_visa = 1
    @participant.save(validate: false)

    redirect_to dashboard_url
  end

  private 
    def restrict_access
      unless current_user.role == 'participant'
        redirect_to dashboard_url, alert: "You don't have the permission to access that page."
      end
    end
end