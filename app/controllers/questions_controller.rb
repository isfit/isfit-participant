class QuestionsController < ApplicationController
  require 'will_paginate/array'
  before_filter :authenticate_user!

  load_and_authorize_resource

  def q_status
    index
  end

  # GET /questions
  # GET /questions.xml
  def index
    selected_status = params[:question][:status] if params[:question]
    selected_functionary = params[:question][:functionaries] if params[:question]
    selected_functionary = nil if selected_functionary ==  ""
    status_query = ""
    @status = selected_status || Question.status_new
    @statuses = Question.status_options
    @functionary = selected_functionary || current_user.id

    status_query = "status = " + @status.to_s
    functionary_query = "fp.functionary_id = "+@functionary.to_s

    if current_user.has_role?(:admin)
      if selected_functionary
        @questions = Question
          .joins(:participant)
          .joins("JOIN functionaries_participants fp ON fp.participant_id = participants.id")
          .where(status_query+" AND "+functionary_query)
          .order("questions.created_at DESC")
          .paginate(:per_page => 10, :page => params[:page])
        @question_counts = Question
          .joins(:participant)
          .joins("JOIN functionaries_participants fp ON fp.participant_id = participants.id")
          .where(functionary_query)
          .group(:status)
          .count
      else
        @questions = Question
          .where(status_query)
          .order("questions.created_at DESC")
          .paginate(:per_page => 10, :page=>params[:page])
        @question_counts = Question.group(:status).count
      end

      @static = Functionary.find_by_sql('SELECT f.first_name as first_name, f.last_name as last_name'\
        ', count(CASE WHEN q.status = 1 THEN f.id END) as new, count(CASE WHEN q.status = 2 THEN f.id END)'\
        ' as opened, count(CASE WHEN q.status = 3 THEN f.id END) as resolved FROM functionaries f'\
        ' JOIN functionaries_participants fp ON fp.functionary_id = f.id JOIN participants p ON p.id'\
        '= fp.participant_id JOIN questions q ON q.participant_id = p.id GROUP BY f.id');
      render :index_nopart
    elsif current_user.has_role?(:dialogue)
      @questions = Question
        .all(:conditions=>"dialogue = 1"+status_query, :order=>"questions.created_at DESC")
        .paginate(:per_page => 10, :page=>params[:page])

      @question_counts = Question.where(:dialogue => 1).group(:status).count

      render :index_nopart
    elsif current_user.has_role?(:functionary)
      @questions = Question.joins(:participant)
        .joins("JOIN functionaries_participants fp ON fp.participant_id = participants.id")
        .where(status_query+" AND fp.functionary_id = "+current_user.functionary.id.to_s)
        .order("questions.created_at DESC")
        .paginate(:per_page => 10, :page => params[:page])

      @question_counts = Question.joins(:participant)
        .joins("JOIN functionaries_participants fp ON fp.participant_id = participants.id")
        .where("fp.functionary_id = "+current_user.functionary.id.to_s)
        .group(:status)
        .count

      render :index_nopart
    else
      @questions = Question.where("participant_id="+current_user.participant.id.to_s)

      @question_counts = Question.where("participant_id="+current_user.participant.id.to_s)
        .group(:status)
        .count

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @questions }
      end     
    end
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id])

    @prev_questions = @question.participant.questions.order("created_at DESC").all
    @answers = Answer.find(:all, :conditions=>{:question_id=>params[:id]})
    if @question.participant.user == current_user || !current_user.is_participant?
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @question }
      end
    else
      raise CanCan::AccessDenied 
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
    @statuses = Question.status_options
  end

  # POST /questions
  # POST /questions.xml
  def create
    @question = Question.new(params[:question])
    @question.dialogue = 0
    @question.participant = current_user.participant
    @question.status = Question.status_new
    respond_to do |format|
      if @question.save
        format.html { redirect_to(@question, :notice => 'Question was successfully created.') }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  #
  def resolve
  @question = Question.find(params[:id])
  @question.status = Question.status_resolved
    if !current_user.is_participant? || @question.participant.user == current_user
	@question.save!
        flash[:notice] = "Question status has been updated to resolved"
        redirect_to(@question)
    else
     raise CanCan::AccessDenied
    end
    
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to(@question, :notice => 'Question was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])

    @question.destroy
    
    respond_to do |format|
      format.html { redirect_to(questions_url) }
      format.xml  { head :ok }
    end
  end
  
end
