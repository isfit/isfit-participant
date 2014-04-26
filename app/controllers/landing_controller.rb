class LandingController < ApplicationController
  def index
    @user = User.new
  end
end
