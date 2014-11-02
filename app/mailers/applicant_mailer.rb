class ApplicantMailer < ActionMailer::Base
  default from: 'no-reply@isfit.org'

  def invitation_mail(user)
    mail(to: user.email, subject: '[ISFiT] Invitation to ISFiT 2015')
  end

  def waiting_list_mail(user)
    mail(to: user.email, subject: '[ISFiT] Regarding your application to ISFiT 2015')
  end

  def rejection_mail(user)
    mail(to: user.email, subject: '[ISFiT] Regarding your application to ISFiT 2015')
  end
end
