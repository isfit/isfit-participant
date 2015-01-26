class DeadlinesController < ApplicationController
  def update_profile
    @profile = current_user.profile
    @profile.attributes = params[:profile]

    participant = current_user.participant

    if @profile.save
      if participant.need_visa == 0
        participant.approved_second_deadline = 1
        participant.save

        redirect_to dashboard_url, notice: 'Your profile was successfully updated and deadline approved'
      else
        redirect_to dashboard_url, notice: 'Your profile was successfully updated'
      end 
    else
      render 'dashboard/deadlines/update_profile'
    end
  end

  def confirm_visa
    @participant = current_user.participant
    @participant.visa_number = params[:participant][:visa_number]

    if @participant.update_attributes(params[:participant])
      @participant.approved_second_deadline = 1
      @participant.save

      redirect_to dashboard_url, notice: 'Visa number accepted and deadline approved'
    else
      render 'dashboard/deadlines/confirm_visa'
    end
  end

  def update_travel_information
    @participant = current_user.participant
    @participant.attributes = params[:participant]

    if @participant.save
      redirect_to dashboard_url, notice: 'Travel information successfully submitted'
    else
      render 'dashboard/deadlines/travel_information'
    end
  end

  def confirm_participation
    @participant = current_user.participant

    if @participant.arrival_in_norway == -1 || @participant.departure_trd == -1 || @participant.departure_norway == -1
      redirect_to dashboard_url, notice: 'You are not allowed to do that' and return
    end

    @participant.confirmed_participation = 1
    @participant.approved_third_deadline = 1

    @participant.save

    begin
      ParticipantMailer.general_information(@participant.user).deliver
    rescue
      puts "Failed sending mail"
    end

    redirect_to dashboard_url, notice: 'See you in Trondheim'
  end
end