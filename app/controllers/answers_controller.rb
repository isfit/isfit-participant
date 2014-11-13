class AnswersController < ApplicationController
  load_and_authorize_resource

  def create
    @question = Question.find(params[:question_id])

    if current_user.role == 'functionary' or @question.status == 3
      @question.status = 2
    end
    
    @answer = @question.answers.new(params[:answer])
    @answer.user = current_user

    if @answer.save && @question.save
      redirect_to @question, notice: 'Answer was successfully added.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @answer.update_attributes(params[:answer])
      redirect_to @answer.question, notice: 'Answer was successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_answer
      @answer = Answer.find(params[:id])
    end
end
