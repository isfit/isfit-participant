class Review::ProfilesController < ApplicationController
  load_and_authorize_resource :workshop_application

  def index
    @applications = WorkshopApplication.paginate(page: params[:page]).joins(:user, :profile).where(users: {role: 'applicant'}).where("profiles.motivation_essay != ''").where("workshop_essay != ''").where("profile_grade IS NULL").order('users.first_name ASC', 'users.last_name ASC')
    current_user_ungraded_applications = WorkshopApplication.ungraded_applications.where(profile_reviewer_id: current_user.id)
    @ungraded_application = current_user_ungraded_applications.order('users.first_name ASC', 'users.last_name ASC').readonly(false).first

    @number_of_applications = WorkshopApplication.joins(:user, :profile).where(users: {role: 'applicant'}).where("profiles.motivation_essay != ''").where("workshop_essay != ''").count
    @number_of_reviewed_applications = WorkshopApplication.joins(:user, :profile).where(users: {role: 'applicant'}).where("profiles.motivation_essay != ''").where("workshop_essay != ''").where("profile_grade IS NOT NULL").count
  end

  def show
    @application = WorkshopApplication.find(params[:id])
  end

  def update
    @application = WorkshopApplication.find(params[:id])
    @application.profile_grade = params[:workshop_application][:profile_grade]

    if @application.save
      redirect_to review_profiles_path, notice: 'Profile grade was successfully set.'
    else
      render :show
    end
  end

  def fetch
    @application = WorkshopApplication.ungraded_applications.where("profile_reviewer_id IS NULL").order('users.first_name ASC', 'users.last_name ASC').readonly(false).first

    if @application.nil?
      redirect_to review_profiles_url, notice: 'No more applications to review.'
    else
      @application.profile_reviewer = current_user
      @application.save(validate: false)

      redirect_to review_profile_url(@application)
    end
  end
end
