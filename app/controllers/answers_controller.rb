class AnswersController < ApplicationController

  # GET /questions/1/answers/1
  # GET /questions/1/answers/1.xml
  def show
    @answer = Answer.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /questions/1/answers/new
  # GET /questions/1/answers/new.xml
  def new
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /questions/1/answers/1/edit
  def edit
    @answer = Answer.find(params[:id])
  end

  # POST /questions/1/answers
  # POST /questions/1/answers.xml
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(params[:answer])

    respond_to do |format|
      if @answer.save
        format.html { redirect_to(@question, :notice => 'Answer was successfully added.') }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1/answers/1
  # PUT /questions/1/answers/1.xml
  def update
    @answer = Answer.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.html { redirect_to(@question, :notice => 'Question was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1/answers/1
  # DELETE /questions/1/answers/1.xml
  def destroy
    @answer = Answer.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(questions_url) }
      format.xml  { head :ok }
    end
  end
end
