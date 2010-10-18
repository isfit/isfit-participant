# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
admin = Role.create(:name => "admin")
functionary = Role.create(:name => "functionary")
participant = Role.create(:name => "participant")

Region.create(:name => "Norden")
Region.create(:name => "Midtøsten")
Region.create(:name => "Asia")

User.create!(:email => "daginge@gmail.com", :password => "123456")
User.create!(:email => "skjervum@isfit.org", :password => "123456")
User.create!(:email => "erisperl@isfit.org", :password => "123456")
User.create!(:email => "amrella@isfit.org", :password => "123456")
Participant.create!(:first_name => "Dag-Inge", :last_name => "Participantville")
Participant.create!(:first_name => "Iver", :last_name => "Participanthouse")
Participant.create!(:first_name => "Erisa", :last_name => "Participanttown")
Participant.create!(:first_name => "Amr", :last_name => "Participantmetropol")

id = User.last.id

Participant.all.reverse.each do |p|
  p.user_id = id
  p.region_id = 3%id
  p.user.roles << participant
  id -= 1
  p.save
end
User.create!(:email => "dagingaa@isfit.org", :password => "123456")
User.create!(:email => "stianfr@isfit.org", :password => "123456")
User.create!(:email => "sindrh@isfit.org", :password => "123456")
User.create!(:email => "audunwi@isfit.org", :password => "123456")

Functionary.create!(:first_name => "Inge-Dag", :last_name => "Functionaryville")
Functionary.create!(:first_name => "Pian", :last_name => "Functionaryhouse")
Functionary.create!(:first_name => "Sindri", :last_name => "Functionarytown")
Functionary.create!(:first_name => "Audis", :last_name => "Functionarymetropol")
id = User.last.id
Functionary.all.reverse.each do |f|
  f.user_id = id
  f.user.roles << functionary
  id -= 1
  f.save
end

User.create!(:email => "root@isfit.org", :password => "123456")
User.last.roles << admin
f = Functionary.create!(:first_name => "Inge-Dag", :last_name => "Functionaryville")
f.user = User.last
f.save

