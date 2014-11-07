class Faq::QuestionsController < ApplicationController
  before_filter :check_permission
  before_filter :set_category, only: [:edit, :update, :destroy]

  def index
    @questions = Faq::Question.with_category
  end

  def new
    @question = Faq::Question.new
  end

  def edit
  end

  def create
    @question = Faq::Question.new(params[:faq_question])

    if @question.save
      redirect_to faq_questions_url, notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  def update
    if @question.update_attributes(params[:faq_question])
      redirect_to faq_questions_url, notice: 'Question was successfully changed.'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to faq_questions_url, notice: 'Question was successfully destroyed.'
  end

  private
    def check_permission
      unless can? :destroy, Faq::Question
        redirect_to dashboard_url, alert: 'You don\'t have permission to access that page.'
      end
    end

    def set_category
      @question = Faq::Question.find(params[:id])
    end
end
