class ApplicantMailer < ActionMailer::Base
  default from: 'no-reply@isfit.org'

  def waiting_list_rejection_mail(user)
    mail(to: user.email, subject: '[ISFiT] Regarding your place on the waiting list')
  end
end
