class FinancialMailer < ActionMailer::Base
  default from: 'no-reply@isfit.org'

  def granted(user)
    mail(to: user.email, subject: '[ISFiT] Regarding your financial aid application')
  end

  def not_granted(user)
    mail(to: user.email, subject: '[ISFiT] Regarding your financial aid application')
  end
end
