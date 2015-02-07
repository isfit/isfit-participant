class DashboardController < ApplicationController
  def index
    if current_user.role == 'admin'
      @number_of_users = User.count
      @number_of_profiles = Profile.count
    end

    if current_user.role == 'participant'
      unless current_user.profile
        redirect_to settings_new_profile_url and return
      end

      @questions = Question.where(user_id: current_user.id)
      render 'index_finished', layout: 'application_dashboard' and return
    else
      render template: role_index_template
    end
  end

  private
    def role_index_template
      'dashboard/index_' + current_user.role.gsub(/-/, '_')
    end
end
