class FunctionariesController < ApplicationController
  before_filter :authenticate_user!
  set_tab :functionaries
  helper_method :sort_column, :sort_direction
  load_and_authorize_resource
  
  # GET /functionaries
  # GET /functionaries.xml
  def index
    @functionaries = Functionary.order(sort_column + ' ' + sort_direction)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @functionaries }
    end
  end

  # GET /functionaries/1
  # GET /functionaries/1.xml
  def show
    @functionary = Functionary.find(params[:id])
    if current_user.has_role?(:admin)
      @participants = Participant.find(:all, :joins=>"JOIN functionaries_participants fp ON fp.participant_id = participants.id", :conditions=>"fp.functionary_id = "+params[:id])
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @functionary }
    end
  end

  def impersonate
    @functionary = Functionary.find(params[:id])
    sign_in(:user, User.find(@functionary.user))
    redirect_to root_url
  end


  # GET /functionaries/1/edit
  def edit
    @functionary = Functionary.find(params[:id])
    if current_user == @functionary.user or current_user.has_role?(:admin)
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @functionary }
      end
    else
      raise CanCan::AccessDenied
    end
  end

  # PUT /functionaries/1
  # PUT /functionaries/1.xml
  def update
    @functionary = Functionary.find(params[:id])
    if current_user == @functionary.user or current_user.has_role?(:admin)
      respond_to do |format|
        if @functionary.update_attributes(params[:functionary])
          format.html { redirect_to(@functionary, :notice => 'Functionary was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @functionary.errors, :status => :unprocessable_entity }
        end
      end
    else
      raise CanCan::AccessDenied
    end
  end
  private
  def sort_column
    Functionary.column_names.include?(params[:sort]) ? params[:sort] : "last_name"
  end
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
