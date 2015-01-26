class ParticipantMailer < ActionMailer::Base
  default from: 'no-reply@isfit.org'
  
  def general_information(user)
    mail(to: user.email, subject: '[ISFiT] Information to all participants')
  end
end
