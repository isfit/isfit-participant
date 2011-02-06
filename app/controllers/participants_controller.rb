class ParticipantsController < ApplicationController
  before_filter :authenticate_user!
  set_tab :profile
  helper_method :sort_column, :sort_direction
  access_control do
    allow :admin
    allow :functionary, :to => [:index, :show]
    allow :sec, :to => [:index, :match, :match_host, :check_in, :check_out]
    allow :participant, :to => [:show, :edit, :update, :travel_support, :invitation]
  end

  def match_host
    @participant = Participant.find(params[:id])
    @host = Host.find(params[:host_id])
    @participant.host = @host
    @participant.save
    redirect_to match_participant_path(@participant)
  end

  def match
    @participant = Participant.find(params[:id])
    @hosts = Host.where("number > 0")

    if @participant.vegetarian
      @hosts = @hosts.where(:vegetarian => 1)
    end
    if @participant.smoke
      @hosts = @hosts.where(:smoker => 0)
    end
    if @participant.arrives_at <= DateTime.civil(2011,02,11)
      @hosts = @hosts.where(:arrival_before => 1)
    end
    #if @participant.departs_at >= DateTime.civil(2011-02-22) && @participants.departs_at <= DateTime.civil(2010-02-23)
    #   @hosts = @hosts.where(:leave_late => 1) 
    #end
    if @participant.allergy_pets
      @hosts = @hosts.where("animal_number = 0")
    end

    @hosts = @hosts.delete_if {|h| h.full? }
  end

  def check_in
    p = Participant.find(params[:id])
    p.checked_in = Time.now()
    p.save
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
    if params[:participant]
      if params[:participant][:region_id].to_i > 0
        region = params[:participant][:region_id]
      else
        region = nil
      end
      params[:participant].delete("region_id")
    end
    if params[:check_in_participant_id]
      a = Participant.find(params[:check_in_participant_id])
      a.checked_in = 1
      a.save
    end
    search_participant
    if current_user.has_role?(:admin) || current_user.has_role?(:sec)
      @partici = Participant.where(@query)
    else
      @partici = Participant.where(:functionary_id => current_user.functionary.id).where(@query)
    end
    if region
      @partici = @partici.joins(:country => :region).where("regions.id = #{region}")
    end
    @participants = @partici.order(sort_column + ' ' + sort_direction).paginate(:per_page => 50, :page=>params[:page])
    @workshop_group = @partici.group(:workshop_id)
    @workshop_count = @workshop_group.count
    @workshops = Workshop.order(:id).all
    @countries = Country.all
    @country_group = @partici.group(:country_id)
    @country_count = @country_group.count.sort_by{|k,v| v}.reverse

    if current_user.has_role?(:sec)
      @partici = @partici.where("checked_in = 0 OR checked_in IS NULL AND guaranteed = 1")
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

  # GET /participants/1
  def show
    if !Deadline.deadline_done?("Visit profile page", current_user)
      Deadline.first.users << current_user
    end
    @participant = Participant.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def invitation
    @participant = Participant.find(params[:id])
    if current_user == @participant.user || !current_user.has_role?(:participant)
      respond_to do |f|
        f.html {render 'invitation', :layout=>false}
      end
    else
      raise Acl9::AccessDenied
    end
  end

  def travel_support
    @participant = Participant.find(params[:id])
    if @participant.travel_support < 1
      raise Acl9::AccessDenied
      return
    end
    if current_user.id == @participant.user.id
      respond_to do |format|
        format.html {render 'travel_support', :layout=>false}
      end
    else
      raise Acl9::AccessDenied
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
    if current_user == @participant.user or current_user.has_role?(:admin, nil)
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @participant }
      end
    else
      raise Acl9::AccessDenied
    end
  end

  # PUT /participants/1
  # PUT /participants/1.xml
  def update
    @participant = Participant.find(params[:id])
    params[:participant].delete("guaranteed")
    if current_user == @participant.user or current_user.has_role?(:admin, nil)
      respond_to do |format|
        if @participant.update_attributes(params[:participant])
          if @participant.applied_for_visa == 1 && !Deadline.deadline_done?("Apply for a visa", current_user)
            d = Deadline.find(4)
            d.users << current_user
          elsif @participant.applied_for_visa == 0 && Deadline.deadline_done?("Apply for a visa", current_user)
            d = Deadline.find(4)
            d.users.delete(current_user)
          end
          if @participant.accepted == 1 && Deadline.find(5).users.index(current_user) == nil
            d = Deadline.find(5)
            d.users << current_user
          elsif @participant.accepted == 0 && Deadline.find(5).users.index(current_user) != nil
            d = Deadline.find(5)
            d.users.delete(current_user)
          end
          format.html { redirect_to(@participant, :notice => 'Participant was successfully updated.') }
        else
          format.html { render :action => "edit" }
        end
      end
    else
      raise Acl9::AccessDenied
    end
  end

  #NIKOLAI WAS HERE

  def search_participant
    @query = ""

    if params[:participant]
      if params[:participant][:region_id]
        region = params[:participant][:region_id]
      else
        region = nil
      end
      params[:participant].delete("region_id")
      @search_participant = Participant.new(params[:participant])
      @search_participant.arrives_at = nil
      first_name = @search_participant.first_name
      last_name = @search_participant.last_name
      email = @search_participant.email
      workshop = @search_participant.workshop_id
      country = @search_participant.country_id
      visa = @search_participant.visa
      accepted = @search_participant.accepted
      has_passport = @search_participant.has_passport
      applied_for_visa = @search_participant.applied_for_visa
      flightnumber = @search_participant.flightnumber
      travel_support = @search_participant.travel_support
      guaranteed = @search_participant.guaranteed
      transport_type = @search_participant.transport_type_id
      arrival_place = @search_participant.arrival_place_id
      unless params[:participant][:arrives_at].blank?
        @arrives_at = params[:participant][:arrives_at]
      else
        @arrives_at = ""
      end
      if first_name != ""
        if @query == ""
          @query = "first_name LIKE '%"+first_name+"%'"
        else
          @query += " AND first_name LIKE '%"+first_name+"%'"
        end
      end
      if last_name != ""
        if @query == ""
          @query = "last_name LIKE '%"+last_name+"%'"
        else
          @query += " AND last_name LIKE '%"+last_name+"%'"
        end
      end
      unless email.blank?
        if @query == ""
          @query = "email LIKE '%"+email+"%'"
        else
          @query += " AND email LIKE '%"+email+"%'"
        end
      end 
      if country == nil
      elsif country != ""
        if @query == ""
          @query = "country_id = " + country.to_s
        else
          @query += " AND country_id = "+ country.to_s
        end
      end
      if workshop == nil
      elsif workshop !=""
        if @query == ""
          @query = "workshop_id = "+workshop.to_s
        else
          @query += " AND workshop_id = "+workshop.to_s
        end
      end
      if accepted == 0
      elsif accepted == 1
        if @query == ""
          @query = "accepted = 1"
        else
          @query += " AND accepted = 1"
        end
      end 
      if visa == 1
        if @query == ""
          @query = "visa = "+visa.to_s
        else
          @query += " AND visa = "+visa.to_s
        end
      end
      if accepted == 1
        if @query == ""
          @query = "accepted = "+accepted.to_s
        else
          @query += " AND accepted = "+accepted.to_s
        end
      end
      if transport_type == nil
      elsif
        if @query == ""
          @query = "transport_type_id = "+transport_type.to_s
        else
          @query += " AND transport_type_id = "+transport_type.to_s
        end
      end
      if arrival_place == nil
      elsif
        if @query == ""
          @query = "arrival_place_id = "+arrival_place.to_s
        else
          @query += " AND arrival_place_id = "+arrival_place.to_s
        end
      end
      if guaranteed
        if @query == ""
          @query = "guaranteed = "+guaranteed.to_s
        else
          @query += " AND guaranteed = "+guaranteed.to_s
        end
      end
      unless @arrives_at.blank?
        if @query == ""
          @query = "arrives_at LIKE '"+@arrives_at+"%'"
        else
          @query += " AND arrives_at LIKE '"+@arrives_at+"%'"
        end
      end
      if applied_for_visa == 1
        if @query == ""
          @query = "applied_for_visa = "+applied_for_visa.to_s
        else
          @query += " AND applied_for_visa = "+applied_for_visa.to_s
        end
      end
      if has_passport == 1
        if @query == ""
          @query = "has_passport = "+has_passport.to_s
        else
          @query += " AND has_passport = "+has_passport.to_s
        end
      end
      if flightnumber == "1"
        if @query == ""
          @query = "flightnumber is not null and flightnumber <> ''"
        else
          @query += " AND flightnumber is not null and flightnumber <> ''"
        end
      end
      if travel_support == 1
        if @query == ""
          @query = "travel_support IS NOT null AND travel_support > 0"
        else
          @query += " AND travel_support is not null AND travel_support > 0"
        end
      end
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

  private
  def sort_column
    Participant.column_names.include?(params[:sort]) ? params[:sort] : "last_name"
  end
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
