class DashboardController < ApplicationController
  def index
    if current_user.has_role?(:admin)
      render template: 'dashboard/index_admin'
    elsif current_user.has_role?(:applicant)
      render template: 'dashboard/index_applicant'
    end
  end
end
