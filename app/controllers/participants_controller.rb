class ParticipantsController < ApplicationController
  before_filter :authenticate_user!
  set_tab :profile
  helper_method :sort_column, :sort_direction
  access_control do
    allow :admin
    allow :functionary, :to => [:index, :show]
    allow :participant, :to => [:show, :edit, :update, :travel_support]
  end

  # GET /participants
  # GET /participants.xml
  def index
    search_participant
    if current_user.has_role?(:admin)
      @participants = Participant.order(sort_column + ' ' + sort_direction).where(@query)
    else
      @participants = Participant.where(:functionary_id => current_user.functionary.id).where(@query).order(sort_column + ' ' + sort_direction)
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
        f.pdf {render 'invitation', :layout=>false}
      end
    else
      raise Acl9::AccessDenied
    end
  end

  def travel_support
    @participant = Participant.find(params[:id])
    if @participant.travel_support < 1
      return
    end
    if current_user.id == @participant.user.id
      respond_to do |format|
        format.pdf { send_data render_to_pdf({ :action => "travel.rpdf"})}
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
    if current_user == @participant.user or current_user.has_role?(:admin, nil)
      respond_to do |format|
        if @participant.update_attributes(params[:participant])
          if @participant.applied_for_visa == 1 && !Deadline.deadline_done?("Apply for a visa", current_user)
            d = Deadline.find(4)
            d.users << current_user
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
       @search_participant = Participant.new(params[:participant])
       first_name = @search_participant.first_name
       last_name = @search_participant.last_name
       email = @search_participant.email
       workshop = @search_participant.workshop

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
      if email !=""
        if @query == ""
          @query = "email LIKE '%"+email+"%'"
        else
          @query += " AND email LIKE '%"+email+"%'"
        end
      end 
      if workshop == nil
      elsif workshop !=""
        if @query == ""
           @query = "workshop LIKE 'workshop'"
        else
          @query += " AND workshop LIKE 'workshop'"
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
