class Applications::WorkshopController < ApplicationController
  before_filter :check_for_missing_profile
  before_filter :check_for_missing_workshop_application, only: [:show, :update]
  before_filter :check_for_existing_workshop_application, only: [:new, :create]
  before_filter :set_workshop_application, only: [:show, :update]

  def show
    render :edit
  end

  def update
    if @workshop_application.update_attributes(params[:workshop_application])
      redirect_to dashboard_url, notice: 'Changes to your workshop application was successfully saved.'
    else
      render :edit
    end
  end

  def new
    @workshop_application = WorkshopApplication.new
    @workshop_application.user = current_user
  end

  def create
    @workshop_application = WorkshopApplication.new
    @workshop_application.user = current_user
    @workshop_application.attributes = params[:workshop_application]

    if @workshop_application.save
      redirect_to dashboard_url, notice: 'Your workshop application was successfully submitted.'
    else
      render :new
    end
  end

  private
    def set_workshop_application
      @workshop_application = current_user.workshop_application
    end

    def check_for_missing_profile
      redirect_to settings_new_profile_url unless current_user.profile
    end

    def check_for_existing_workshop_application
      redirect_to applications_workshop_url if current_user.workshop_application
    end

    def check_for_missing_workshop_application
      redirect_to new_applications_workshop_url unless current_user.workshop_application
    end
end
