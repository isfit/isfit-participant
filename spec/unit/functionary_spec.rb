require 'spec_helper'

describe Functionary do
	it "has full name" do
		functionary = Functionary.new(first_name: "Ola", last_name: "Nordmann")
		functionary.full_name.should eq("Ola Nordmann")
	end

	it "can be saved" do
		c = Functionary.all.count
		f = Functionary.create
		f.save.should eq(true)
		(Functionary.all.count).should eq(c+1)
	end
end
