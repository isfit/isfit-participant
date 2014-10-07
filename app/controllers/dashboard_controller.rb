class DashboardController < ApplicationController
  def index
    if current_user.role == 'admin'
      @number_of_users = User.count
      @number_of_profiles = Profile.count

      render template: 'dashboard/index_admin'
    elsif current_user.role == 'functionary-participant'
      render template: 'dashboard/index_functionary_participant'
    elsif current_user.role == 'applicant'
      unless current_user.profile
        redirect_to settings_new_profile_url and return
      end

      render template: 'dashboard/index_applicant'
    end
  end
end
