# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
IsfitParticipant::Application.initialize!

ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false

# Rails fikser dette i 3.2
#Mime::Type.register 'application/pdf', :pdf
