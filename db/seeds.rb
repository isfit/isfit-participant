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
dialogue = Role.create(:name => "dialogue")
ArrivalPlace.create(:name => "Trondheim")
ArrivalPlace.create(:name => "Oslo")

TransportType.create(:name => "Plane")
TransportType.create(:name => "Train")
TransportType.create(:name => "Bus")


User.create!(:email => "root@isfit.org", :password => "123456")
User.last.roles << admin
f = Functionary.create!(:first_name => "Inge-Dag", :last_name => "Functionaryville")
f.user = User.last
f.save

Deadline.create(:name=>"Visit profile page", :deadline=>"2010-11-15 23:59")
Deadline.create(:name=>"Get visa", :deadline=>"2010-12-15 23:59")
Deadline.create(:name=>"Past deadline....", :deadline=>Time.now)

QuestionStatus.create(:name=>"New")
QuestionStatus.create(:name=>"Open")
QuestionStatus.create(:name=>"Resolved")
#Functionary.all.each do |f|
#  f.participants.each do |p|
#    p.functionaries << f
#    p.save
#  end
#end
