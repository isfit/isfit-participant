#Create roles
admin = Role.create(:name => "admin")
Role.create(:name => "theme")
Role.create(:name => "functionary")
Role.create(:name => "sec")
Role.create(:name => "dialogue")
Role.create(:name => "participant")
Role.create(:name => "applicant")

#Create arrival places
ArrivalPlace.create(:name => "Oslo")
ArrivalPlace.create(:name => "Trondheim")

#Create transport types
TransportType.create(:id => 5, :name => "Plane")
TransportType.create(:id => 6,:name => "Train")
TransportType.create(:id => 7,:name => "Bus")
TransportType.create(:id => 8,:name => "Car")

#Create control panel entry
ControlPanel.create(:app_grade1 => 0, :app_grade2 => 0, :app_grade3 => 0, :app_grade2_scope => 0)

#Create first user
User.create!(:email => "root@isfit.org", :password => "sdfiky7f23ohfasldjfbd923hd29bhsidywqdhwejdbuiwhdo8ncskdncjkshfi2o3")
User.last.roles << admin
f = Functionary.create!(:first_name => "Placeholder", :last_name => "Placeholdersen")
f.user = User.last
f.save

#Deadlines
Deadline.create(:name => "1. Accept invitation", :deadline => "2014-11-15 23:59", :participant_type: => 1)
Deadline.create(:name => "2. Apply for visa", :deadline => "2014-11-15 23:59", :participant_type: => 1)
Deadline.create(:name => "3. Embassy confirmation", :deadline => "2014-11-15 23:59", :participant_type: => 1)
Deadline.create(:name => "4. Valid passport", :deadline => "2014-11-15 23:59", :participant_type: => 1)
Deadline.create(:name => "5. Update profile", :deadline => "2014-11-15 23:59", :participant_type: => 1)
Deadline.create(:name => "6. Granted vias", :deadline => "2014-12-15 23:59", :participant_type: => 1)
Deadline.create(:name => "7. Need transport", :deadline => "2015-01-15 23:59", :participant_type: => 1)
Deadline.create(:name => "8. Flight tickets", :deadline => "2015-01-15 23:59", :participant_type: => 1)
Deadline.create(:name => "9. Confirm participation", :deadline => "2015-01-15 23:59", :participant_type: => 1)
Deadline.create(:name => "1. Accept waiting-list", :deadline => "2014-11-15 23:59", :participant_type: => 2)

#Countries???

#Remember to change password
puts "#############################################################################################"
puts "#############################################################################################"
puts "### CHANGE PLACEHOLDER PASSWORD #############################################################"
puts "#############################################################################################"
puts "#############################################################################################"
