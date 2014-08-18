class Applications::MotivationController < ApplicationController
  before_filter :check_for_missing_profile
  before_filter :set_profile

  def edit
  end

  def update
    if @profile.update_attributes(params[:profile])
      redirect_to dashboard_url, notice: 'Your motivation essay was successfully saved.'
    else
      render :edit
    end
  end

  private
    def set_profile
      @profile = current_user.profile
    end

    def check_for_missing_profile
      redirect_to settings_new_profile_url unless current_user.profile
    end
end
