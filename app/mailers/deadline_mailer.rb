class DeadlineMailer < ActionMailer::Base
  default from: "no-reply@isfit.org"

  def failed_december_deadline(user)
    mail(to: user.email, subject: '[ISFiT] Deadline not met')
  end

  def january_reminder(user)
    mail(to: user.email, subject: '[ISFiT] Reminder from ISFiT')
  end
end
