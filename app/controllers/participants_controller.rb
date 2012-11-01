class ParticipantsController < ApplicationController
  before_filter :authenticate_user!
  set_tab :profile

  load_and_authorize_resource

  def match_host
    @participant = Participant.find(params[:id])
    @host = Host.find(params[:host_id])
    if not @participant.host.nil?
      @participant.host = @host
      @participant.save
      flash[:notice] = "Participant matched"
      redirect_to match_participant_path(@participant)
    else
      flash[:warning] = "Participant taken"
      redirect_to match_participant_path(@participant)
    end

  end

  def match
    @participant = Participant.find(params[:id])
    @hosts = Host.where("number > 0")
    @showall = false
    if @participant.vegetarian
      @hosts = @hosts.where(:vegetarian => 1)
    end
    if @participant.smoke
      @hosts = @hosts.where(:smoker => 0)
    end
    if @participant.arrives_at != nil
    if @participant.arrives_at <= DateTime.civil(2011,02,11)
      @hosts = @hosts.where(:arrival_before => 1)
    end
    end
    if @participant.departs_at != nil
    if @participant.departs_at >= DateTime.civil(2011-02-22) && @participant.departs_at <= DateTime.civil(2010-02-23)
       @hosts = @hosts.where(:leave_late => 1) 
    end
    end
    if @participant.allergy_pets
      @hosts = @hosts.where("animal_number = 0")
    end
    if @hosts.empty?
     @hosts = Host.where("number > 0")
     @showall = true
    end 
    @hosts = @hosts.delete_if {|h| h.full? }
  end

  def check_in
    p = Participant.find(params[:id])
    p.checked_in = Time.now()
    p.save
    flash[:notice] = "#{p.last_name}, #{p.first_name} is checked in"
    redirect_to participants_path
  end

  def check_out
    p = Participant.find(params[:id])
    p.checked_out = Time.now()
    p.save
    redirect_to participants_path
  end

  # GET /participants
  # GET /participants.xml
  def index
    @q = Participant.search params[:q]
    @participants = @q.result(distinct: true).paginate(per_page: 15, page: params[:page])

    if current_user.has_role?(:admin) || current_user.has_role?(:sec)
      @partici = Participant.where(@query)
    else
      @partici = Participant.where(:functionary_id => current_user.functionary.id).where(@query)
    end

    #@participants = @partici.order(sort_column + ' ' + sort_direction).paginate(:per_page => 50, :page=>params[:page])
    @workshop_group = @partici.group(:workshop_id)
    @workshop_count = @workshop_group.count
    @workshops = Workshop.order(:id).all
    @countries = Country.all
    @country_group = @partici.group(:country_id)
    @country_count = @country_group.count.sort_by{ |k,v| v }.reverse

    if current_user.has_role?(:sec)
      @partici = @partici.where("guaranteed = 1")
    	@participants = @partici.order(sort_column + ' ' + sort_direction).paginate(:per_page => 50, :page=>params[:page])
      respond_to do |f|
        f.html {render 'index_sec'}
      end
      return
    end
    respond_to do |format|
      format.html # index.html.erb 
      format.js
    end
  end

  def deadlines
    if current_user.has_role?(:admin)
      redirect_to participants_path
    end
  end

  def deadlines_handler
    @participant = Participant.find(params[:id])
    if current_user.has_role?(:admin) or not current_user == @participant.user
      redirect_to participants_path
    end

    #accept invitation
    if not Deadline.find_by_id(1).users.include?(current_user) and current_user.participant.invited and current_user.participant.active and params[:deadline].to_i == 1 
      @participant.accepted = params[:participant][:accepted]
      @participant.active = @participant.accepted == 1 ? true : false
      if @participant.save
        DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 1)
        if @participant.accepted == 1
          flash[:notice] = "Your invitation was accepted."
        else
          flash[:alert] = "Your invitation was rejected."
        end
        render 'show'
      else
        render 'deadline'
      end
    elsif not Deadline.find_by_id(2).users.include?(current_user) and current_user.participant.invited and current_user.participant.active and params[:deadline].to_i == 2
      @participant.applied_for_visa = params[:participant][:applied_for_visa]
      if @participant.save
        DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 2)
        if @participant.applied_for_visa == -1
          DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 3)
          DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 6)
        elsif @participant.applied_for_visa == 0
          @participant.active = false
          @participant.save
        end
        flash[:notice] = "You information was successfully updated."
        render 'show'
      else
        render 'deadline'
      end
    elsif not Deadline.find_by_id(3).users.include?(current_user) and current_user.participant.invited and current_user.participant.active and params[:deadline].to_i == 3 
      @participant.embassy_confirmation = params[:participant][:embassy_confirmation]
      if @participant.save
        DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 3)
        flash[:notice] = "Participant was successfully updated."
        render 'show'
      else
        render 'deadline'
      end
    elsif not Deadline.find_by_id(4).users.include?(current_user) and current_user.participant.invited and current_user.participant.active and params[:deadline].to_i == 4 
      @participant.has_passport = params[:participant][:has_passport]
      if @participant.has_passport == 0
        @participant.active = false
      end
      if @participant.save
        DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 4)
        flash[:notice] = "Participant was successfully updated."
        render 'show'
      else
        render 'deadline'
      end
    elsif not Deadline.find_by_id(6).users.include?(current_user) and current_user.participant.invited and current_user.participant.active and params[:deadline].to_i == 6 
      @participant.visa = params[:participant][:visa]
      @participant.visa_number = params[:participant][:visa_number]
      @participant.visum = params[:participant][:visum]
      if @participant.visa == 0
        @participant.active = false
      end
      if @participant.save
        DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 6)
        flash[:notice] = "Participant was successfully updated."
        render 'show'
      else
        render 'deadline'
      end
    elsif not Deadline.find_by_id(7).users.include?(current_user) and current_user.participant.invited and current_user.participant.active and params[:deadline].to_i == 7 
      @participant.need_transport = params[:participant][:need_transport]
      if @participant.save
        DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 7)
        flash[:notice] = "Participant was successfully updated."
        render 'show'
      else
        render 'deadline'
      end
    elsif not Deadline.find_by_id(8).users.include?(current_user) and current_user.participant.invited and current_user.participant.active and params[:deadline].to_i == 8 
      @participant.transport_type_id = params[:participant][:transport_type_id]
      @participant.flightnumber = params[:participant][:flightnumber]
      @participant.arrives_at = DateTime.new(params[:participant]['arrives_at(1i)'].to_i, params[:participant]['arrives_at(2i)'].to_i, params[:participant]['arrives_at(3i)'].to_i, params[:participant]['arrives_at(4i)'].to_i, params[:participant]['arrives_at(5i)'].to_i)
      @participant.departs_at = DateTime.new(params[:participant]['departs_at(1i)'].to_i, params[:participant]['departs_at(2i)'].to_i, params[:participant]['departs_at(3i)'].to_i, params[:participant]['departs_at(4i)'].to_i, params[:participant]['departs_at(5i)'].to_i)
      @participant.arrival_place_id = params[:participant][:arrival_place_id]
      if @participant.save
        DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 8)
        flash[:notice] = "Participant was successfully updated."
        render 'show'
      else
        render 'deadline'
      end
    elsif not Deadline.find_by_id(9).users.include?(current_user) and current_user.participant.invited and current_user.participant.active and params[:deadline].to_i == 9
      @participant.confirmed_participation = params[:participant][:confirmed_participation]
      if not @participant.confirmed_participation
        @participant.active = false
      end
      if @participant.save
        DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 9)
        flash[:notice] = "Participant was successfully updated."
        render 'show'
      else
        render 'deadline'
      end
    elsif not Deadline.find_by_id(10).users.include?(current_user) and not current_user.participant.invited and current_user.participant.active and params[:deadline].to_i == 10 
      @participant.agree_waiting_list = params[:participant][:agree_waiting_list]
      if @participant.save
        DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 10)
        flash[:notice] = "Participant was successfully updated."
        render 'show'
      else
        render 'deadline'
      end

    else
      redirect_to participant_path(@participant)
    end
  end

  def approve_deadline
    @participant = Participant.find(params[:id])

    if params[:deadline].to_i == 5
      if params[:approved].to_i == 1 
        d = DeadlinesUser.where("deadline_id = 5 and user_id = ?", @participant.user.id).first
        d.approved = true
        d.save
        flash[:notice] = "Deadline was approved"
        redirect_to validate_deadline_participants_path
      else
        d = DeadlinesUser.where("deadline_id = 5 and user_id = ?", @participant.user.id).first
        d.destroy
        flash[:warning] = "Deadline was removed"
        redirect_to validate_deadline_participants_path
      end      
    elsif params[:deadline].to_i == 6
      if params[:approved].to_i == 1 
        d = DeadlinesUser.where("deadline_id = 6 and user_id = ?", @participant.user.id).first
        d.approved = true
        d.save
        flash[:notice] = "Deadline was approved"
        redirect_to validate_deadline_participants_path
      else
        d = DeadlinesUser.where("deadline_id = 6 and user_id = ?", @participant.user.id).first
        d.destroy
        flash[:warning] = "Deadline was removed"
        redirect_to validate_deadline_participants_path
      end
    elsif params[:deadline].to_i == 8
      if params[:approved].to_i == 1 
        d = DeadlinesUser.where("deadline_id = 8 and user_id = ?", @participant.user.id).first
        d.approved = true
        d.save
        flash[:notice] = "Deadline was approved"
        redirect_to validate_deadline_participants_path
      else
        d = DeadlinesUser.where("deadline_id = 8 and user_id = ?", @participant.user.id).first
        d.destroy
        flash[:warning] = "Deadline was removed"
        redirect_to validate_deadline_participants_path
      end 
    else
      flash[:warning] = "Unknown deadline"
      redirect_to validate_deadline_participants_path
    end
  end

  def check_deadline
    @participant = Participant.find(params[:id])
  end

  def validate_deadline
    @participants = current_user.functionary.participants.includes("user").where("invited = 1")
  end

  # GET /participants/search
  def search
    @q = Participant.search params[:q]
    @participants = @q.result(distinct: true).paginate(per_page: 15, page: params[:page])

    respond_to do |format|
      format.html # search.html.erb
    end
  end

  # GET /participants/1
  def show
    @participant = Participant.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def stats
    @participants = Participant.all
  end

  def invitation
    @participant = Participant.find(params[:id])
    if (current_user == @participant.user || !current_user.has_role?(:participant)) and @participant.invited
      respond_to do |f|
        f.html {render 'invitation', :layout=>false}
      end
    else
      raise CanCan::AccessDenied
    end
  end

  def travel_support
    @participant = Participant.find(params[:id])
    if @participant.travel_support < 1
      raise CanCan::AccessDenied
      return
    end
    if current_user.id == @participant.user.id || !current_user.has_role?(:participant)
      respond_to do |format|
        format.html {render 'travel_support', :layout=>false}
      end
    else
      raise CanCan::AccessDenied
    end
  end

  def letter_of_recommendation
    @participant = Participant.find(params[:id])
    if @participant.travel_support < 1
      raise CanCan::AccessDenied
      return
    end
    if current_user.id == @participant.user.id || !current_user.has_role?(:participant)
      respond_to do |format|
        format.html {render 'letter_of_recommendation', :layout=>false}
      end
    else
      raise CanCan::AccessDenied
    end
  end

  def secure
    @participant = Participant.find(params[:id])
    @participant.guaranteed = 1
    if @participant.save
      respond_to do |format|
        flash[:notice] = "Participant secured"
        format.html {redirect_to(participant_path(@participant))}
      end
    else
      respond_to do |format|
        flash[:warning] = "Participant not secured, something went wrong"
        format.html {redirect_to(@participant)}
      end
    end
  end
  
  def desecure
    @participant = Participant.find(params[:id])
    @participant.guaranteed = 0
    if @participant.save
      respond_to do |format|
        flash[:notice] = "Participant guarantee removed"
        format.html {redirect_to(participant_path(@participant))}
      end
    else
      respond_to do |format|
        flash[:warning] = "Participant still secured, something went wrong"
        format.html {redirect_to(@participant)}
      end
    end
  end

  # GET /participants/1/edit
  def edit
    @participant = Participant.find(params[:id])
    @accepted = @participant.accepted
    if current_user == @participant.user or current_user.has_role?(:admin) or current_user.has_role?(:functionary)
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @participant }
      end
    else
      raise CanCan::AccessDenied
    end
  end

  # PUT /participants/1
  # PUT /participants/1.xml
  def update
    @participant = Participant.find(params[:id])
    params[:participant].delete("guaranteed")
    if current_user.has_role?(:admin) or current_user.has_role?(:functionary)
      @participant.first_name = params[:participant][:first_name]
      @participant.last_name = params[:participant][:last_name]
      @participant.save
    end
    if current_user == @participant.user or current_user.has_role?(:admin) or current_user.has_role?(:functionary)
      respond_to do |format|
        if @participant.update_attributes(params[:participant])
          if not Deadline.find_by_id(5).users.include?(current_user)
            DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 5)
          end
          format.html { redirect_to(@participant, :notice => 'Participant was successfully updated.') }
        else
          format.html { render :action => "edit" }
        end
      end
    else
      raise CanCan::AccessDenied
    end
  end

  def mail_to_search_results

    search_participant
    if current_user.has_role?(:admin)
      @participants = Participant.order(sort_column + ' ' + sort_direction).where(@query)
    else
      @participants = Participant.where(:functionary_id => current_user.functionary.id).where(@query).order(sort_column + ' ' + sort_direction)
    end


    if params[:mailform]

      subject = params[:mailform][:subject]
      text = params[:mailform][:text]

      respond_to do |format|
        format.js
      end


      @participants.each do |a|
        sleep(0.5)
        ParticipantsMailer.send_mail(a, subject, text) 
      end
    end
  end
end
