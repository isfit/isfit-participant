class ParticipantsController < ApplicationController
  before_filter :authenticate_user!
  set_tab :profile
  access_control do
    allow :admin
    allow :functionary, :to => [:index, :show]
    allow :participant, :to => [:show, :edit, :update]
  end

  # GET /participants
  # GET /participants.xml
  def index
    @participants = Participant.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @participants }
    end
  end

  # GET /participants/1
  # GET /participants/1.xml
  def show    
    @participant = Participant.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @participant }
      format.pdf { send_data render_to_pdf({ :action => 'show.rpdf'})}#, :layout => 'pdf_report' })} 
    end
  end

  # GET /participants/1/edit
  def edit
    @participant = Participant.find(params[:id])
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
          format.html { redirect_to(@participant, :notice => 'Participant was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @participant.errors, :status => :unprocessable_entity }
        end
      end
    else
      raise Acl9::AccessDenied
    end
  end
end
