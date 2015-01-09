class ParticipantsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @participants = Participant.paginate(page: params[:page]).joins(:user)
      .order('users.first_name ASC', 'users.last_name ASC')
      .where(approved_first_deadline: [1, 2])

    if params[:search].present?
      k = "%#{params[:search]}%"
      @participants = @participants
        .where("users.first_name LIKE ? OR users.last_name LIKE ? OR users.email LIKE ?", k, k, k)
    end
  end

  def show
    @participant = Participant.find(params[:id])
  end

  def update
    @participant = Participant.find(params[:id])
    @participant.approved_second_deadline = params[:participant][:approved_second_deadline]

    if @participant.save(validate: false)
      redirect_to participants_path, notice: 'Second deadline extended.'
    else
      render :show
    end
  end
  def match_list
    @participants = Participant.where('host_id IS NULL').paginate(page: params[:page])
    render 'hosts/match/index'
  end
  def match
    @participant = Participant.find(params[:id])
    #Fix this later
    temphosts = Host.all
    @hosts = Array.new
    temphosts.each do |h|
      if h.has_free_beds?
        @hosts.push h
      end
    end
    @hosts = @hosts.paginate(page: params[:page])
    render 'hosts/match/host/index'
  end
  def apply_match
    participant = Participant.find(params[:participant_id])
    participant.host_id = params[:host_id]
    participant.save
    match_list()
  end
end
