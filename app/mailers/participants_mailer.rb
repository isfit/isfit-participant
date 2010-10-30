class ParticipantsMailer < ActionMailer::Base
  default :from => "no-reply@isfit.org"

  def send_mail(reciever, subject, text)
    @text = text
    @reciver = reciever
    mail_with_name = "#{a.last_name}, #{a.first_name} <#{a.email}>"
    mail(:to => email_with_name, :subject => subject) do |format|
      format.html
      format.text
    end 
  end
  
end
