class ParticipantsController < ApplicationController
  before_filter :authenticate_user!
  set_tab :profile

  require 'will_paginate/array'

  load_and_authorize_resource

  def match_host
    @participant = Participant.find(params[:id])
    @host = Host.find(params[:host_id])

    if @host.full?
      flash[:alert] = "Host #{@host.full_name} has no more free beds! Please find another host for #{@participant.full_name}."
    elsif @participant.has_host?
      flash[:alert] = "Participant #{@participant.full_name} has already been given a host, please find another participant for #{@host.full_name}."
    else
      @participant.host = @host
      @participant.save
      flash[:notice] = "#{@participant.full_name} will be hosted by #{@host.full_name}."
    end

    redirect_to host_path(@host)
  end

  def remove_host
    @participant = Participant.find(params[:id])
    @host        = Host.find(params[:host_id])

    @participant.host_id = nil
    @participant.save
    flash[:notice] = "#{@participant.full_name} was removed from #{@host.full_name}"

    redirect_to host_path(@host)
  end

  def match
    @participant = Participant.find(params[:id])

    @hosts = Host
      .where("number > 0")
      .where(deleted: 0)
    @hosts = @hosts.delete_if { |h| h.full? }
    @hosts = @hosts.paginate(per_page: 10, page: params[:page])
  end

  def check_in
    p = Participant.find(params[:id])
    p.checked_in = Time.now()
    p.save
    flash[:notice] = "#{p.last_name}, #{p.first_name} is checked in"
    redirect_to add_phone_number_participant_path(p)
  end

  def remove_check_in
    p = Participant.find(params[:id])
    if p.checked_in.nil?
      flash[:notice] = "Participant is not checked in already."
    else
      p.checked_in = nil
      p.save
      flash[:notice] = "#{p.last_name}, #{p.first_name} is no longer checked in."
    end
    redirect_to participant_path(p)
  end

  def check_out
    p = Participant.find(params[:id])
    p.checked_out = Time.now()
    p.save
    redirect_to participants_path
  end

  def add_phone_number
    @participant = Participant.find(params[:id])

    respond_to do |f|
      f.html
    end
  end

  def update_phone_number
    @participant.phone_number = params[:participant][:phone_number]

    @participant.save
    redirect_to match_participant_path(@participant)
  end

  # GET /participants
  # GET /participants.xml
  def index
    @q = Participant.search params[:q]

    if current_user.has_role?(:sec)
      @participants = @q
        .result(distinct: true)
        .where("guaranteed = 1 OR dialogue = 1")
        .paginate(per_page: 10, page: params[:page])

      respond_to do |f|
        f.html {render 'index_sec'}
      end
      return
    end

    @participants = @q.result(distinct: true).paginate(per_page: 15, page: params[:page])

    if current_user.has_role?(:admin)
      @partici = Participant.where(@query)
    else
      @partici = Participant.where(:functionary_id => current_user.functionary.id).where(@query)
    end

    #@participants = @partici.order(sort_column + ' ' + sort_direction).paginate(:per_page => 50, :page=>params[:page])
    
    respond_to do |format|
      format.html # index.html.erb 
      format.js
    end
  end

  # GET /participants/graphics
  def graphics
    if current_user.has_role?(:admin) || current_user.has_role?(:sec)
      @partici = Participant.where(:invited => 1, :active => 1)
    else
      @partici = Participant.where(:functionary_id => current_user.functionary.id)
    end

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
      format.html # graphics.html.erb 
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
      if params[:participant].nil?
        flash[:alert] = "You have to choose one of the options."
        return render 'deadlines'
      end
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
        render 'deadlines'
      end
    elsif not Deadline.find_by_id(2).users.include?(current_user) and current_user.participant.invited and current_user.participant.active and params[:deadline].to_i == 2
      if params[:participant].nil?
        flash[:alert] = "You have to choose one of the options."
        return render 'deadlines'
      end
      @participant.applied_for_visa = params[:participant][:applied_for_visa]
      if @participant.applied_for_visa != 0 and @participant.save 
        DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 2)
        flash[:notice] = "You information was successfully updated."
        render 'show'
      elsif @participant.applied_for_visa == 0
        flash[:alert] = "You have to apply for a visa or come from a visa-free country to continue."
        return redirect_to deadlines_participant_path
      else
        render 'deadlines'
      end
    elsif not Deadline.find_by_id(3).users.include?(current_user) and current_user.participant.invited and current_user.participant.active and params[:deadline].to_i == 3 
      @participant.embassy_confirmation = params[:participant][:embassy_confirmation]
      if @participant.save
        DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 3)
        flash[:notice] = "Participant was successfully updated."
        render 'show'
      else
        render 'deadlines'
      end
    elsif not Deadline.find_by_id(4).users.include?(current_user) and current_user.participant.invited and current_user.participant.active and params[:deadline].to_i == 4 
      if params[:participant].nil?
        flash[:alert] = "You have to choose one of the options."
        return render 'deadlines'
      end
      @participant.has_passport = params[:participant][:has_passport]
      if @participant.has_passport == 0
        flash[:alert] = "You need to have a valid passport to continue."
        redirect_to deadlines_participant_path
      elsif @participant.save
        DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 4)
        flash[:notice] = "Participant was successfully updated."
        render 'show'
      else
        render 'deadlines'
      end
    elsif not Deadline.find_by_id(5).users.include?(current_user) and current_user.participant.invited and current_user.participant.active and params[:deadline].to_i == 5 
      if not params[:temp].nil? and params[:temp][:edit_profile].to_i == 1
        DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 5)
        flash[:notice] = "Participant was successfully updated."
        render 'show'
      else
        flash[:alert] = "You need to update your profile before you can continue."
        redirect_to deadlines_participant_path
      end

    elsif not Deadline.find_by_id(6).users.include?(current_user) and current_user.participant.invited and current_user.participant.active and params[:deadline].to_i == 6 
      @participant.visa = params[:participant][:visa]
      @participant.visa_number = params[:participant][:visa_number]
      @participant.visum = params[:participant][:visum]
      if @participant.save
        DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 6)
        flash[:notice] = "Participant was successfully updated."
        render 'show'
      else
        render 'deadlines'
      end
    elsif not Deadline.find_by_id(7).users.include?(current_user) and current_user.participant.invited and current_user.participant.active and params[:deadline].to_i == 7 
      if not params[:participant].nil?
        @participant.need_transport = params[:participant][:need_transport]
      else
        flash[:alert] = "You have to choose one of the options."
        return render 'deadlines'
      end
      if @participant.save
        DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 7)
        flash[:notice] = "Participant was successfully updated."
        render 'show'
      else
        render 'deadlines'
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
        render 'deadlines'
      end
    elsif not Deadline.find_by_id(9).users.include?(current_user) and current_user.participant.invited and current_user.participant.active and params[:deadline].to_i == 9
      @participant.confirmed_participation = params[:participant][:confirmed_participation]
      if not @participant.confirmed_participation
        flash[:alert] = "You have to confirm your participation if you want to attend at ISFiT"
        return redirect_to deadlines_participant_path
      else
        @participant.guaranteed = true
      end
      if @participant.save
        DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 9)
        flash[:notice] = "Participant was successfully updated."
        render 'show'
      else
        render 'deadlines'
      end
    elsif not Deadline.find_by_id(10).users.include?(current_user) and not current_user.participant.invited and current_user.participant.active and params[:deadline].to_i == 10 
      if params[:participant].nil?
        flash[:alert] = "You have to choose one of the options."
        return render 'deadlines'
      end
      @participant.agree_waiting_list = params[:participant][:agree_waiting_list]
      if @participant.save
        DeadlinesUser.create(:user_id => current_user.id, :deadline_id => 10)
        flash[:notice] = "Participant was successfully updated."
        render 'show'
      else
        render 'deadlines'
      end

    else
      redirect_to participant_path(@participant)
    end
  end

  def approve_deadline
    @participant = Participant.find(params[:id])
    d = DeadlinesUser.where("deadline_id = ? and user_id = ?", params[:deadline].to_i, @participant.user.id).first

    if d.nil?
      flash[:alert] = "This deadline has not been done by the participant."
      return redirect_to validate_deadline_participants_path
    end

    if params[:approved].to_i == 1 and not d.approved 
      d.approved = true
      d.save
      if @participant.active
        DeadlineMailer.deadline_approved(@participant, d.deadline_id).deliver
      end
      flash[:notice] = "Deadline was approved."
      redirect_to validate_deadline_participants_path
    elsif params[:approved].to_i == 0 and not d.approved
      d.destroy
      if @participant.active
        DeadlineMailer.deadline_not_approved(@participant, d.deadline_id).deliver
      end
      flash[:notice] = "Deadline was not approved."
      redirect_to validate_deadline_participants_path
    elsif d.approved
      flash[:alert] = "This deadline is already approved."
      redirect_to validate_deadline_participants_path
    else
      flash[:alert] = "Something went wrong."
      redirect_to validate_deadline_participants_path
    end        
  end

  def check_deadline
    @participant = Participant.find(params[:id])
  end

  def validate_deadline
    if current_user.has_role?(:admin)
      @participants = Participant.includes("user").where("invited = 1").paginate(:per_page => 50, :page => params[:page])
    else
      @participants = current_user.functionary.participants.includes("user").where("invited = 1")
    end
    @deadlines = Deadline.where("participant_type = 1")
  end

  def deadlines_and_functionaries
      @functionaries = Functionary.includes(:participants).select {|f| f.participants.length > 0 }
      @deadline_five  = Participant.find_by_sql("SELECT functionaries_participants.functionary_id, COUNT(*) as count FROM `participants`"\
          " INNER JOIN `deadlines_users` ON participants.user_id = deadlines_users.user_id INNER JOIN "\
          "`functionaries_participants` ON functionaries_participants.participant_id = participants.id "\
          "WHERE deadline_id = 5 and approved = 0 and invited = 1 GROUP BY "\
          "functionaries_participants.functionary_id")
      @deadline_six   = Participant.find_by_sql("SELECT functionaries_participants.functionary_id, COUNT(*) as count FROM `participants`"\
          " INNER JOIN `deadlines_users` ON participants.user_id = deadlines_users.user_id INNER JOIN "\
          "`functionaries_participants` ON functionaries_participants.participant_id = participants.id "\
          "WHERE deadline_id = 6 and approved = 0 and invited = 1 GROUP BY "\
          "functionaries_participants.functionary_id")
      @deadline_eight = Participant.find_by_sql("SELECT functionaries_participants.functionary_id, COUNT(*) as count FROM `participants`"\
          " INNER JOIN `deadlines_users` ON participants.user_id = deadlines_users.user_id INNER JOIN "\
          "`functionaries_participants` ON functionaries_participants.participant_id = participants.id "\
          "WHERE deadline_id = 8 and approved = 0 and invited = 1 GROUP BY "\
          "functionaries_participants.functionary_id")
  end

  # GET /participants/search
  def search
    @q = Participant.search params[:q]

    @sort_by = params[:sort_by]
    @sort_by = "id" if @sort_by == "" || @sort_by.nil?

    #FIX ME
    @functionary = params[:functionary]
    @functionary = nil if @functionary ==  ""
    @deadline = params[:deadline]
    @deadline = nil if @deadline ==  ""
    unless params[:arrives_at].nil? 
      @arrives_at = params[:arrives_at][:arrives_at]
    else
      @arrives_at = ""
    end

    #FIX ME
    @participants = nil
    if @functionary and @deadline
      @participants = @q
        .result(distinct: true)
        .joins("JOIN functionaries_participants fp ON fp.participant_id = participants.id")
        .joins("JOIN deadlines_users du ON du.user_id = participants.user_id")
        .where("fp.functionary_id = "+@functionary.to_s)
        .where("deadline_id = ? AND approved = 0", @deadline.to_i)
        .where("coalesce(date(arrives_at), '') LIKE ?", "#{@arrives_at}%")
        .paginate(per_page: 15, page: params[:page])
        .order("#{@sort_by} ASC")
    elsif @deadline
      @participants = @q
        .result(distinct: true)
        .joins("JOIN deadlines_users du ON du.user_id = participants.user_id")
        .where("deadline_id = ? AND approved = 0", @deadline.to_i)
        .where("coalesce(date(arrives_at), '') LIKE ?", "#{@arrives_at}%")
        .paginate(per_page: 15, page: params[:page])
        .order("#{@sort_by} ASC")
    elsif @functionary
      @participants = @q
        .result(distinct: true)
        .joins("JOIN functionaries_participants fp ON fp.participant_id = participants.id")
        .where("fp.functionary_id = "+@functionary.to_s)
        .where("coalesce(date(arrives_at), '') LIKE ?", "#{@arrives_at}%")
        .paginate(per_page: 15, page: params[:page])
        .order("#{@sort_by} ASC")
    else
      @participants = @q
        .result(distinct: true)
        .where("coalesce(date(arrives_at), '') LIKE ?", "#{@arrives_at}%")
        .paginate(per_page: 15, page: params[:page])
        .order("#{@sort_by} ASC")
    end

    @sortable_fields = Participant.sortable_fields

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

  def isfit_transportation
    @participant = Participant.find(params[:id])
    if (current_user == @participant.user || !current_user.has_role?(:participant)) and @participant.invited
      respond_to do |f|
        f.html {render 'isfit_transportation', :layout=>false}
      end
    else
      raise CanCan::AccessDenied
    end
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

  def ignore
    @participant = Participant.find(params[:id])
    @participant.ignore = true
    if @participant.save
      respond_to do |format|
        flash[:notice] = "Participant added to ignore list"
        format.html {redirect_to(participant_path(@participant))}
      end
    else
      respond_to do |format|
        flash[:warning] = "Something went wrong"
        format.html {redirect_to(@participant)}
      end
    end
  end

  def unignore
    @participant = Participant.find(params[:id])
    @participant.ignore = false
    if @participant.save
      respond_to do |format|
        flash[:notice] = "Participant removed from ignore list"
        format.html {redirect_to(participant_path(@participant))}
      end
    else
      respond_to do |format|
        flash[:warning] = "Something went wrong"
        format.html {redirect_to(@participant)}
      end
    end
  end

  def activate
    @participant = Participant.find(params[:id])
    @participant.active = true
    if @participant.save
      respond_to do |format|
        flash[:notice] = "Participant is now active, and can continue on deadlines."
        format.html {redirect_to(participant_path(@participant))}
      end
    else
      respond_to do |format|
        flash[:warning] = "Something went wrong"
        format.html {redirect_to(@participant)}
      end
    end
  end

  def deactivate
    @participant = Participant.find(params[:id])
    @participant.active = false
    @participant.guaranteed = false
    if @participant.save
      respond_to do |format|
        flash[:notice] = "Participant removed from deadlines"
        format.html {redirect_to(participant_path(@participant))}
      end
    else
      respond_to do |format|
        flash[:warning] = "Something went wrong"
        format.html {redirect_to(@participant)}
      end
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
    if current_user.has_role?(:admin)
      @participant.accepted = params[:participant][:accepted]
      @participant.applied_for_visa = params[:participant][:applied_for_visa]
      @participant.embassy_confirmation = params[:participant][:embassy_confirmation]
      @participant.need_transport = params[:participant][:need_transport]
      @participant.transport_type_id = params[:participant][:transport_type_id]
      @participant.flightnumber = params[:participant][:flightnumber]
      @participant.arrives_at = DateTime.new(params[:participant]['arrives_at(1i)'].to_i, params[:participant]['arrives_at(2i)'].to_i, params[:participant]['arrives_at(3i)'].to_i, params[:participant]['arrives_at(4i)'].to_i, params[:participant]['arrives_at(5i)'].to_i)
      @participant.departs_at = DateTime.new(params[:participant]['departs_at(1i)'].to_i, params[:participant]['departs_at(2i)'].to_i, params[:participant]['departs_at(3i)'].to_i, params[:participant]['departs_at(4i)'].to_i, params[:participant]['departs_at(5i)'].to_i)
      @participant.arrival_place_id = params[:participant][:arrival_place_id]
      @participant.save
    end
    if current_user == @participant.user or current_user.has_role?(:admin) or current_user.has_role?(:functionary)
      respond_to do |format|
        if @participant.update_attributes(params[:participant])
          format.html { redirect_to(@participant, :notice => 'Participant was successfully updated.') }
        else
          format.html { render :action => "edit" }
        end
      end
    else
      raise CanCan::AccessDenied
    end
  end

  def impersonate
    @participant = Participant.find(params[:id])
    sign_in(:user, User.find(@participant.user))
    redirect_to root_url
  end

  def show_workshop
    @participant = Participant.find(params[:id])
    @application = Application.where("email = ?", @participant.user.email).first
    @workshops = Workshop.all
  end

  def update_workshop
    @participant = Participant.find(params[:id])
    @old_workshop = @participant.workshop_id
    @participant.workshop_id = params[:participant][:workshop_id]

    if @participant.save
      flash[:notice] = "The workshop was changed."
      redirect_to participants_workshop_path(@old_workshop)
    else
      @workshops = Workshop.all
      flash[:alert] = "Something went wrong."
      render 'show_workshop'
    end
  end
end
