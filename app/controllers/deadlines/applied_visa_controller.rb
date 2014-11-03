class Deadlines::AppliedVisaController < ApplicationController
  def show
  end

  def update
    @participant = current_user.participant

    @participant.applied_visa = 1
    @participant.save

    redirect_to dashboard_url
  end
end