class ParticipantsMailer < ActionMailer::Base
  default :from => "question@isfit.org"

  def send_mail(reciever, subject, text)
    @text = text
    @reciver = reciever
    mail_with_name = "#{a.last_name}, #{a.first_name} <#{a.email}>"
    mail(:to => email_with_name, :subject => subject) do |format|
      format.html
      format.text
    end 
  end

  def invitation_letter(participant)
    @participant = participant
    mail(to: participant.email, subject: "[ISFiT] Your invitation to ISFiT 2013")
  end

  def waiting_list(participant)
    @participant = participant
    mail(to: participant.email, subject: "[ISFiT] Regarding your application to ISFiT 2013")
  end

  def denied(participant)
    @participant = participant
    mail(to: participant.email, subject: "[ISFiT] Regarding your application to ISFiT 2013")
  end
  
end
