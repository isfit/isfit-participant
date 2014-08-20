class Applications::DialogueController < ApplicationController
  before_filter :check_for_missing_profile
  before_filter :check_for_existing_dialogue_application, only: [:new, :create]
  before_filter :check_for_missing_dialogue_application, only: [:edit, :update]
  before_filter :set_dialogue_application, only: [:edit, :update]
  before_filter :check_current_user_country

  def new
    @dialogue_application = DialogueApplication.new
  end

  def create
    @dialogue_application = DialogueApplication.new(params[:dialogue_application])
    @dialogue_application.user = current_user

    if @dialogue_application.save
      redirect_to dashboard_url, notice: 'Your dialogue application was successfully created!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @dialogue_application.update_attributes(params[:dialogue_application])
      redirect_to dashboard_url, notice: 'Your dialogue application was successfully changed'
    else
      render :edit
    end
  end

  private
    def set_dialogue_application
      @dialogue_application = current_user.dialogue_application
    end

    def check_for_existing_dialogue_application
      redirect_to applications_edit_dialogue_url if current_user.dialogue_application
    end

    def check_for_missing_dialogue_application
      redirect_to applications_new_dialogue_url unless current_user.dialogue_application
    end

    def check_for_missing_profile
      redirect_to settings_new_profile_url unless current_user.profile
    end

    def check_current_user_country
      unless current_user.profile.from_conflict_area?
        redirect_to dashboard_url, 
          notice: 'The dialogue groups are only open for students from Burundi, Rwanda, and South-Africa.' 
      end
    end
end
