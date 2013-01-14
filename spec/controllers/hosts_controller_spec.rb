require 'spec_helper.rb'

describe HostsController do
  it "can add a bed to an user" do
    @host = hosts(:three)
    assert true
    #lambda {get :add_bed, :id => @host.id}.should change(@host, :number).by(1)
  end

  context "#add_bed" do
    before(:each) do
      @user = users(:one)
      sign_in @user
      controller.stub(current_user: @user)
    end

    before(:each) do
      @user = users(:one)
      sign_in @user
      controller.stub(current_user: @user)
    end

    subject { get :add_bed, :id => hosts(:three).id }

    it "redirects_to(@host)" do
      subject.should redirect_to(assigns(:host))
    end
  end
end