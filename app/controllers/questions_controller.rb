class QuestionsController < ApplicationController
  before_filter :authenticate_user!
  set_tab :question
  access_control do
    allow :admin
    allow :functionary, :to => [:index, :show, :edit, :update, :q_status]
    allow :participant, :to => [:index, :show, :edit, :update, :new, :create, :follow_new]
  end

  def q_status
    index  
  end

  # GET /questions
  # GET /questions.xml
  def index

    if current_user.has_role?(:admin)
      @questions = Question.all(:conditions=>"question_id IS NULL")
      @followquestions = Question.all(:conditions=>"question_id IS NOT NULL")
      render :index_nopart
    elsif current_user.has_role?(:functionary)
      selected_status = params[:status]
      statusq = ""
      @status = QuestionStatus.first
      @statuses = QuestionStatus.all
      if selected_status != nil
        statusq = " AND question_status_id = "+selected_status
        @status = QuestionStatus.find(selected_status)
      else
        statusq = " AND question_status_id = 1"
      end
      @questions = Question.all(:joins=>"JOIN participants ON participants.id = questions.participant_id", :conditions=>"question_id IS NULL AND participants.functionary_id = "+current_user.functionary.id.to_s+statusq)
      @followquestions = Question.all(:joins=>"JOIN participants ON participants.id = questions.participant_id", :conditions=>"question_id IS NOT NULL AND participants.functionary_id = "+current_user.functionary.id.to_s+statusq)
      render :index_nopart
    else
      @questions = Question.find(:all, :conditions=>"participant_id="+current_user.participant.id.to_s+" AND question_id IS NULL")
      @followquestions = Question.all(:conditions=>"question_id IS NOT NULL")
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
    if @question.question_id != nil
      parent = Question.find(@question.question_id)
    else
      parent = Question.new
      parent.participant_id = -1
    end
    @answers = Answer.find(:all, :conditions=>{:question_id=>params[:id]})
    if @question.participant.user == current_user || !current_user.is_participant? || parent.participant.user == current_user
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @question }
      end
    else
      raise Acl9::AccessDenied 
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
    @statuses = QuestionStatus.all
    if !current_user.is_participant? || @question.participant.user == current_user
      
    else
      raise Acl9::AccessDenied
    end 
  end

  # POST /questions
  # POST /questions.xml
  def create
    @question = Question.new(params[:question])
    @question.dialogue = 0
    @question.participant = current_user.participant
    @question.question_status = QuestionStatus.find(:first, :conditions=>{:name=>:New})
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

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = Question.find(params[:id])
    #@question.question_status = QuestionStatus.find(params[:status])
    if !current_user.is_participant? || @question.participant.user == current_user
      respond_to do |format|
        if @question.update_attributes(params[:question])
          format.html { redirect_to(@question, :notice => 'Question was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
        end
      end
    else
      raise Acl9::AccessDenied
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
  
  # GET /questions/follow_new/1
  def follow_new
    @question = Question.new
    @question.question_id = params[:id]
    respond_to do |format|
      format.html # follow_new.html.erb
      format.xml  { render :xml => @question }
    end
  end
end
