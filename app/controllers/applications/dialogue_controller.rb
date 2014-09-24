class Applications::DialogueController < ApplicationController
  before_filter :check_for_missing_profile
  before_filter :check_for_existing_dialogue_application, only: [:new, :create]
  before_filter :check_for_missing_dialogue_application, only: [:show, :update]
  before_filter :set_dialogue_application, only: [:show, :update]
  before_filter :check_current_user_country

  def show
    render :edit
  end

  def new
    @dialogue_application = DialogueApplication.new
    @dialogue_application.user = current_user
  end

  def create
    @dialogue_application = DialogueApplication.new
    @dialogue_application.user = current_user
    @dialogue_application.attributes = params[:dialogue_application]

    if @dialogue_application.save
      redirect_to dashboard_url, notice: 'Changes to your dialogue application was successfully saved.'
    else
      render :new
    end
  end

  def update
    if @dialogue_application.update_attributes(params[:dialogue_application])
      redirect_to dashboard_url, notice: 'Your dialogue application was successfully submitted.'
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
      unless current_user.profile.related_to_conflict_area?
        redirect_to dashboard_url, 
          notice: 'The dialogue groups are only open for students from Burundi, Rwanda, and South-Africa.' 
      end
    end
end
