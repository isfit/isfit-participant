require 'spec_helper'

describe ParticipantsController do
	context "as admin" do
		fixtures :users, :roles, :user_roles, :participants

		before(:each) do
			user = users(:one)
			controller.stub(current_user: user)
		end

		it "GET index" do
			participant = stub_model(Participant)
			Participant.stub(:all) { [participant] }
			get :index
			expect(assigns(:participants)).to eq([participant])
		end
	end
end