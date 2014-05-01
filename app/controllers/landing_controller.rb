class LandingController < ApplicationController
  def index
    redirect_to dashboard_url and return if user_signed_in?
    @user = User.new
  end
end
