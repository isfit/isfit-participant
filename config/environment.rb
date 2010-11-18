# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
IsfitParticipant::Application.initialize!

ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false


Mime::Type.register 'application/pdf', :pdf
