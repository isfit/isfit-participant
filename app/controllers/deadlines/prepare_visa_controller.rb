class Deadlines::PrepareVisaController < ApplicationController
  def show
  end
  
  def update
    @participant = current_user.participant

    if params[:commit] == 'Yes'
      @participant.need_visa = 1
    else
      @participant.need_visa = 0
    end

    @participant.save
    redirect_to dashboard_url
  end
end