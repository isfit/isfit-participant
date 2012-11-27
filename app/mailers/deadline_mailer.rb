class DeadlineMailer < ActionMailer::Base
  default from: "no-reply@isfit.org"

  def deadline_approved(participipant, num)
    @participant = participant
    @deadline_number = num
    mail(:to => participant.email, :subject => "[ISFiT] Notification from participant-web")
  end

  def deadline_not_approved(participipant, num)
    @participant = participant
    @deadline_number = num
    mail(:to => participant.email, :subject => "[ISFiT] Notification from participant-web")
  end
end
