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
    mail_with_name = "#{participant.last_name}, #{participant.first_name} <#{participant.email}>"
    mail(to: mail_with_name, subject: "Insert something")
  end

  def waiting_list(participant)
    @participant = participant
    mail_with_name = "#{participant.last_name}, #{participant.first_name} <#{participant.email}>"
    mail(to: mail_with_name, subject: "Insert something")
  end

  def denied(participant)
    @participant = participant
    mail_with_name = "#{participant.last_name}, #{participant.first_name} <#{participant.email}>"
    mail(to: mail_with_name, subject: "Insert something")
  end
  
end
