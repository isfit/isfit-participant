class ParticipantsController < ApplicationController
  def index
    @participants = Participant.paginate(page: params[:page])
  end
  def show
    @participant = Participant.find(params[:id])
  end
  def update
    @participant = Participant.find(params[:id])
    @participant.applied_visa = params[:participant][:applied_visa]

    if @participant.save
      redirect_to participants_path, notice: 'Workshop application grade was successfully set.'
    else
      render :show
    end
  end
end
