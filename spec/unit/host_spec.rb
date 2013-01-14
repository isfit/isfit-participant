require 'spec_helper.rb'

describe Host do
  it "has full name" do
    host = hosts(:one)
    host.full_name.should eq(host.first_name + " " + host.last_name)
  end

  it "can be student" do
    host = hosts(:two)
    host.student.should eq("Yes")
  end

  it "can have student set to nil" do
    host = hosts(:one)
    host.student.should eq("Not registered") 
  end

  it "can be non-student" do
    host = hosts(:three)
    host.student.should eq("No")
  end

  it "can have a participant" do
    host = hosts(:one)
    host.participants.length.should eq(1)
  end

  it "has a number of free beds" do
    host = hosts(:one)
    beds_left = host.number - host.participants.length
    host.number_left.should eq(beds_left)
  end

  it "can be full" do
    host = hosts(:two)
    host.full?.should eq(true)
  end
end