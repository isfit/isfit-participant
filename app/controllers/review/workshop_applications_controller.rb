class Review::WorkshopApplicationsController < ApplicationController
  load_and_authorize_resource

  def index
    @applications = WorkshopApplication.
      valid.passed_profile_review.not_wa_reviewed.
      order('users.first_name ASC', 'users.last_name ASC').
      paginate(page: params[:page])

    @ungraded_application = WorkshopApplication.
      valid.passed_profile_review.not_wa_reviewed.
      where(workshop_application_reviewer_id: current_user.id).
      order('users.first_name ASC', 'users.last_name ASC').first
  end

  def show
    @application = WorkshopApplication.find(params[:id])
  end

  def update
    @application = WorkshopApplication.find(params[:id])
    @application.workshop_application_grade = params[:workshop_application][:workshop_application_grade]
    @application.workshop_recommendation_id = params[:workshop_application][:workshop_recommendation_id]

    if @application.save
      redirect_to review_workshop_applications_url, notice: 'Workshop application grade was successfully set.'
    else
      render :show
    end
  end

  def fetch
    @application = WorkshopApplication.valid.
      passed_profile_review.not_wa_reviewed.has_no_reviewer

    unless current_user.workshop
      @application = @application.where(workshop_1_id: current_user.workshop.id)
    end

    @application = @application.order('users.first_name ASC', 'users.last_name ASC').readonly(false).first

    if @application.nil?
      redirect_to review_workshop_applications_url, notice: 'No more applications to review.'
    else
      @application.workshop_application_reviewer = current_user
      @application.save(validate: false)

      redirect_to [:review, @application]
    end
  end
end