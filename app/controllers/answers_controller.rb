class AnswersController < ApplicationController

  # POST /questions/1/answers
  # POST /questions/1/answers.xml
  def create
    @question = Question.find(params[:question_id])
    if current_user.is_functionary?
      @question.status = 2
    end
    
    @answer = @question.answers.create(params[:answer])
    @answer.user_id = current_user.id
    respond_to do |format|
      if @answer.save && @question.save
        format.html { redirect_to(@question, :notice => 'Answer was successfully added.') }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end
end
