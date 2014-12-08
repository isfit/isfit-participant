class DeadlineMailer < ActionMailer::Base
  default from: "no-reply@isfit.org"

  def deadline_approved(participant, num)
    @participant = participant
    @deadline_num = num
    mail(:to => participant.email, :subject => "[ISFiT] Notification from participant-web")
  end

  def deadline_not_approved(participant, num)
    @participant = participant
    @deadline_num = num
    mail(:to => participant.email, :subject => "[ISFiT] Notification from participant-web")
  end

  def november_reminder_visa(user)
    mail(to: user.email, subject: '[ISFiT] Reminder from ISFiT')
  end

  def november_reminder_no_visa(user)
    mail(to: user.email, subject: '[ISFiT] Reminder from ISFiT')
  end

  def failed_first_deadline(user)
    mail(to: user.email, subject: '[ISFiT] Deadline not met')
  end


  def december_reminder_visa(user)
    mail(to: user.email, subject: '[ISFiT] Reminder from ISFiT')
  end

  def december_reminder_no_visa(user)
    mail(to: user.email, subject: '[ISFiT] Reminder from ISFiT')
  end

end
