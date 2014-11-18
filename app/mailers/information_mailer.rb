class InformationMailer < ActionMailer::Base
  default from: "no-reply@isfit.org"

  def new_questions(user)
    mail to: user.email, subject: '[ISFiT] Information about questions to ISFiT'
  end
end
