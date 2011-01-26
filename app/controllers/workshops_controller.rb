class WorkshopsController < ApplicationController
  before_filter :authenticate_user!
  set_tab :workshop
  access_control do
    allow :admin
    allow :functionary, :to => [:index, :show]
    allow :participant, :to => [:show]
  end

  def index
   @workshops = Workshop.all
  end

  def show
    if not current_user.is_participant?
      @workshop = Workshop.find(params[:id])
    else
      @workshop = current_user.participant.workshop
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

end
