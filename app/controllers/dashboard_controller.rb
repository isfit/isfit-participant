class DashboardController < ApplicationController
  def index
    if current_user.has_role?(:admin)
      @number_of_users = User.count
      @number_of_profiles = Profile.count

      render template: 'dashboard/index_admin'
    elsif current_user.has_role?(:applicant)
      render template: 'dashboard/index_applicant'
    end
  end
end
