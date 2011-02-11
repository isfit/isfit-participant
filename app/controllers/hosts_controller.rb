class HostsController < ApplicationController
  before_filter :authenticate_user!
  set_tab :host

  access_control do
    allow :admin
    allow :sec
  end

  def add_bed
    @host = Host.find(params[:id])
    @host.number += 1
    @host.save
    flash[:notice] = "Added 1 bed for host successfully"
    redirect_to(host_path(@host))
  end

  def remove_bed
    @host = Host.find(params[:id])
    @host.number -= 1
    @host.save
    flash[:notice] = "Removed 1 bed for host successfully"
    redirect_to(host_path(@host))
  end


  def index
    @hosts = Host.all
  end
  def show
    @host = Host.find(params[:id]) 
    if params[:participant_id] && @host.participants.count <= @host.number
      @host.participants << Participant.find(params[:participant_id])
    end
    if params[:remove_participant_id]
      p = Participant.find(params[:remove_participant_id])
      p.host_id = nil
      p.save
    end
    @showall = false
    @host = Host.find(params[:id])
    @participants = Participant.where("checked_in IS NOT NULL AND host_id IS NULL")
    @search_participant = Participant.new(params[:participant])
    unless params[:participant]
      @search_participant.vegetarian = true
      @search_participant.smoke = true
    end
    if !@host.vegetarian && @search_participant.vegetarian
      @participants = @participants.where("vegetarian = 0 OR vegetarian IS NULL")
    end
    if !@host.smoker && @search_participant.smoke
      @participants = @participants.where("smoke = 0 OR smoke  IS NULL")
    end
    if !@host.arrival_before
    #  @participants = @participants.where("arrives_at > '2011-02-10%'")
    end
    if !@host.leave_late
    #   @participants = @participants.where("departs_at < '2011-02-21%'") 
    end
    if @host.animal_number > 0
      @participants = @participants.where("allergy_pets = 0 OR allergy_pets IS NULL")
    end
    if @search_participant.country
      @participants = @participants.where(:country_id => @search_participant.country_id)
    end
    if @participants.empty?
      @participants = Participant.where("checked_in IS NOT NULL AND host_id IS NULL")
      @showall = true
    end
  end

end
