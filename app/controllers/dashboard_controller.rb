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

      get_participant_step
    else
      render template: role_index_template
    end
  end

  private
    def role_index_template
      'dashboard/index_' + current_user.role.gsub(/-/, '_')
    end

    def get_participant_step
      # Load data
      participant = current_user.participant
      profile = current_user.profile

      # Check if profile is updated
      if profile.next_of_kin_not_completed?
        @profile = current_user.profile
        template = 'dashboard/deadlines/update_profile'
      elsif participant.need_visa == 1 && participant.not_completed_applied_visa?
        redirect_to deadlines_applied_visa_url and return
      elsif participant.need_visa == 1 && participant.visa_number.blank?
        @participant = current_user.participant
        template = 'dashboard/deadlines/confirm_visa'
      elsif participant.arrival_in_norway == -1 || participant.departure_trd == -1 || participant.departure_norway == -1
        @participant = participant
        template = 'dashboard/deadlines/travel_information'
      end
      
      render template || 'index_wait'
    end
end
