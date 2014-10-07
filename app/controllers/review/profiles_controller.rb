class Review::ProfilesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @applications = WorkshopApplication.paginate(page: params[:page]).joins(:user, :profile).where(users: {role: 'applicant'}).where("profiles.motivation_essay != ''").where("profile_grade IS NULL").order('users.first_name ASC', 'users.last_name ASC')

    @number_of_applications = WorkshopApplication.joins(:user, :profile).where(users: {role: 'applicant'}).where("profiles.motivation_essay != ''").count
    @number_of_reviewed_applications = WorkshopApplication.joins(:user, :profile).where(users: {role: 'applicant'}).where("profiles.motivation_essay != ''").where("profile_grade IS NOT NULL").count
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
end