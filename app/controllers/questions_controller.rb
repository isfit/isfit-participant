class QuestionsController < ApplicationController
  require 'will_paginate/array'

  load_and_authorize_resource

  def q_status
    index
  end

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

    if current_user.role == 'admin'
      @questions = Question.order("questions.created_at DESC").where(status_query)
        .paginate(:per_page => 10, :page => params[:page])

      render :index_nopart
    elsif current_user.role == 'dialogue'
      @questions = Question
        .all(:conditions=>"dialogue = 1"+status_query, :order=>"questions.created_at DESC")
        .paginate(:per_page => 10, :page=>params[:page])

      @question_counts = Question.where(:dialogue => 1).group(:status).count

      render :index_nopart
    elsif current_user.role == 'functionary'
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
      @questions = Question.where(user_id: current_user.id)
      @question_counts = Question.where(user_id: current_user.id).group(:status).count    
    end
  end

  def show
    @question = Question.find(params[:id])

    unless current_user == @question.user || (can? :manage, Question)
      raise CanCan::AccessDenied
    end

    @prev_questions = @question.user.questions.order("created_at DESC").all
    @answers = Answer.find(:all, :conditions=>{:question_id=>params[:id]})
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
    @statuses = Question.status_options
  end

  def create
    @question = Question.new(params[:question])
    @question.user = current_user
    @question.status = Question.status_new

    if @question.save
      redirect_to(@question, :notice => 'Question was successfully created.')
    else
      render :new
    end
  end

  def resolve
    @question = Question.find(params[:id])
    @question.status = Question.status_resolved
    @question.save

    redirect_to @question, notice: 'Question status has been updated to resolved'
  end

  def update
    @question = Question.find(params[:id])

    if @question.update_attributes(params[:question])
      redirect_to @question, notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])

    @question.destroy
    redirect_to questions_url
  end 
end