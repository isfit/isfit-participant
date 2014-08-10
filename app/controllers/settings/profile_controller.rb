class Settings::ProfileController < ApplicationController
  before_filter :check_for_existing_profile, only: [:new, :create]
  before_filter :check_for_missing_profile, only: [:edit, :update]
  before_filter :set_profile, only: [:edit, :update]

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(params[:profile])
    @profile.user = current_user

    if @profile.save
      redirect_to dashboard_url, notice: 'Your profile was successfully created. We can\'t wait for your application!'
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @profile.update_attributes(params[:profile])
      redirect_to settings_edit_profile_url, notice: 'Your profile was successfully changed'
    else
      render :edit
    end
  end

  private
    def set_profile
      @profile = current_user.profile
    end

    def check_for_existing_profile
      redirect_to settings_edit_profile_url if current_user.profile
    end

    def check_for_missing_profile
      redirect_to settings_new_profile_url unless current_user.profile
    end
end
