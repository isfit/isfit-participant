class AnswersController < ApplicationController

  # POST /questions/1/answers
  # POST /questions/1/answers.xml
  def create
    @question = Question.find(params[:question_id])
    if current_user.role == 'functionary' or @question.status == 3
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

  def edit
    @answer = Answer.find(params[:id])
    raise CanCan::AccessDenied unless current_user.is_functionary? && current_user.id == @answer.user_id
  end

  def update
    @answer = Answer.find(params[:id])
    
    if current_user.is_functionary? && current_user.id == @answer.user_id
      respond_to do |format|
        if @answer.update_attributes(params[:answer])
          format.html { redirect_to(@answer.question, :notice => 'Answer was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
        end
      end
    else
      raise CanCan::AccessDenied
    end
  end
end
