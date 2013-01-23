class WorkshopsController < ApplicationController
  before_filter :authenticate_user!
  set_tab :workshop

  load_and_authorize_resource

  def index
   @workshops = Workshop.all
  end

  def show
    if not current_user.is_participant?
      @workshop = Workshop.find(params[:id])
    elsif not current_user.participant.workshop.nil?
      @workshop = current_user.participant.workshop
    else
      raise CanCan::AccessDenied
    end
  end

  def allergies
    @workshop = Workshop.find(params[:id])
    if @workshop.id == 18
      @participants = Workshop.find(params[:id]).participants.where("dialogue = 1")
    else
      @participants = Workshop.find(params[:id]).participants.where("invited = 1 AND active = 1 AND guaranteed = 1")
    end
  end

  def edit
    @workshop = Workshop.find(params[:id])
  end

  def update
    @workshop = Workshop.find(params[:id])
    
    if @workshop.update_attributes(params[:workshop])
      redirect_to(@workshop, :notice => 'Workshop was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def participants
    @workshop = Workshop.find(params[:id])
    
    if @workshop.id == 18
      @participants = Workshop.find(params[:id]).participants.where("dialogue = 1").includes(:country)
    else
      @participants = Workshop.find(params[:id]).participants.where("invited = 1 AND active = 1 AND guaranteed = 1").includes(:country)
    end
  end
end
