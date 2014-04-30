class LandingController < ApplicationController
  layout 'landing'

  def index
    redirect_to dashboard_url if user_signed_in?

    @user = User.new
  end
end
