class ParticipantsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @participants = Participant.paginate(page: params[:page]).joins(:user)
      .order('users.first_name ASC', 'users.last_name ASC')
      .where(approved_first_deadline: [1, 2], approved_second_deadline: [1, 2])

    if params[:search].present?
      k = "%#{params[:search]}%"
      @participants = @participants
        .where("users.first_name LIKE ? OR users.last_name LIKE ? OR users.email LIKE ?", k, k, k)
    end
    if params[:only_checked_in].present? && params[:only_checked_in] == "1"
      @participants = @participants.where("checked_in = 1")
    end
    if params[:country].nil? == false && params[:country][:country_id].present? == true
      @participants = @participants.joins(:profile).where('country_id = ? OR citizenship_id = ?',params[:country][:country_id], params[:country][:country_id])
    end
  end

  def update #Only used for updating internal comments
    @participant = Participant.find(params[:id])
    @participant.internal_comments = params[:participant][:internal_comments]

    if @participant.save
      flash[:notice] = 'Successfully updated participant'
    else
      flash[:alert] = 'An error occurred, please try again'
    end
    redirect_to participant_path(@participant)
  end

  def show
    @participant = Participant.find(params[:id])
  end

  def match_list
    @participants = Participant.paginate(page: params[:page]).joins(:user)
    .order('users.first_name ASC', 'users.last_name ASC')
    .where(approved_first_deadline: [1, 2])
    @participants = @participants.where('host_id IS NULL')
    if params[:search].present?
      k = "%#{params[:search]}%"
      @participants = @participants
      .where("users.first_name LIKE ? OR users.last_name LIKE ? OR users.email LIKE ?", k, k, k)
    end
    if params[:only_checked_in].present? && params[:only_checked_in] == "1"
      @participants = @participants.where("checked_in = 1")
    end
    if params[:country].nil? == false && params[:country][:country_id].present? == true
      @participants = @participants.joins(:profile).where('country_id = ? OR citizenship_id = ?',params[:country][:country_id], params[:country][:country_id])
    end
    #@participants = @participants.paginate(page: params[:page])
    if params[:match_now].blank?
      @match_now = false
    else
      @match_now = true
      @host = Host.find(params[:host_id])
    end
    render 'hosts/match/index'
  end
  def match
    @participant = Participant.find(params[:id])
    #Fix this later
    temphosts = Host.get_all_non_deleted
    if params[:search].present?
      k = "%#{params[:search]}%"
      temphosts = temphosts
      .where("firstname LIKE ? OR lastname LIKE ?", k, k)
    end
    if !params[:gender_pref].blank?
      temphosts = temphosts.where("sex = ?",params[:gender_pref])
    end
    if !params[:animals].blank?
      temphosts = temphosts.where("animales = ?",params[:animals])
    end
    if !params[:day_early].blank?
      temphosts = temphosts.where("Onedayearly = ?",params[:day_early])
    end
    if !params[:day_late].blank?
      temphosts = temphosts.where("extraday = ?",params[:day_late])
    end
    if !params[:student].blank?
      temphosts = temphosts.where("isstudent = ?",params[:student])
    end
    if !params[:hosted_before].blank?
      temphosts = temphosts.where("beenhost = ?",params[:hosted_before])
    end
    @hosts = Array.new
    #temphosts.each do |h|
      #if h.has_free_beds?
        #@hosts.push h
      #end
    #end
    @hosts = temphosts #Remove if uncommenting above
    @hosts = @hosts.paginate(page: params[:page])
    render 'hosts/match/host/index'
  end
  def apply_match
    participant = Participant.find(params[:participant_id])
    if participant.host_id.nil?
      participant.host_id = params[:host_id]
      if participant.save
        flash[:notice] = 'Host and participant matched successfully'
      else
        flash[:alert] = 'An error occurred, please try again'
      end
    else
      flash[:alert] = 'This participant has already been matched with a host'
    end
    #match_list()
    redirect_to host_path(params[:host_id])
  end
  def unmatch
    session[:return_to] = request.referer
    participant = Participant.find(params[:participant_id])
    participant.host_id = nil
    if participant.save
      flash[:notice] = 'Host and participant unmatched successfully'
    else
      flash[:alert] = 'An error occurred, please try again'
    end
    redirect_to session.delete(:return_to)
  end
  def lock_host
    session[:return_to] = request.referer
    participant = Participant.find(params[:participant_id])
    if participant.host_id.nil?
      flash[:alert] = "Unable to lock because no host is set"
    else
      participant.host_locked = true
      if participant.save
        flash[:notice] = 'Matching successfully locked'
      else
        flash[:alert] = 'An error occured, please try again'
      end
    end
    redirect_to session.delete(:return_to)
  end
  def check_in
    session[:return_to] = request.referer
    participant = Participant.find(params[:participant_id])
    participant.checked_in = true
    participant.check_in_time = DateTime.now
    if participant.save
      flash[:notice] = 'Participant successfully checked in'
    else
      flash[:alert] = 'An error occured, please try again'
    end
    redirect_to session.delete(:return_to)
  end
end
