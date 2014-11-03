class DashboardController < ApplicationController
  def index
    if current_user.role == 'admin'
      @number_of_users = User.count
      @number_of_profiles = Profile.count

      render template: 'dashboard/index_admin'
    elsif current_user.role == 'functionary-participant'
      render template: 'dashboard/index_functionary_participant'
    elsif current_user.role == 'functionary-workshop'
      render template: 'dashboard/index_functionary_participant'
    elsif current_user.role == 'participant'
      participant
    elsif current_user.role == 'applicant'
      unless current_user.profile
        redirect_to settings_new_profile_url and return
      end

      if [2, 4].any? {|code| code == current_user.workshop_application.status}
        redirect_to waiting_list_url and return
      end

      if current_user.created_at > DateTime.new(2014, 10, 7, 0, 0, 0, '+02:00')
        render template: 'dashboard/index_applicant_late_recruit'
      else
        render template: 'dashboard/index_applicant'
      end
    end
  end

  private
    def participant
      current_participant = current_user.participant

      if current_participant.accepted_invitation == 0
        render 'index_not_accepted_invitation' and return
      end

      if current_participant.not_completed_prepare_visa?
        redirect_to deadlines_prepare_visa_url
      elsif current_participant.not_completed_invitation?
        redirect_to deadlines_invitation_url
      elsif current_participant.need_visa == 1 && current_participant.not_completed_applied_visa?
        redirect_to deadlines_applied_visa_url
      else
        render 'index_wait'
      end
    end
end
