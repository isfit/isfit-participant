class UserMailer < ActionMailer::Base
  default from: "no-reply@isfit.org"

  def functionary_mail(user)
    @user = user
    @url = "https://participant.isfit.org/"
    mail(:to => user.email, :subject => "Tilgang til deltakerweb")
  end
end
