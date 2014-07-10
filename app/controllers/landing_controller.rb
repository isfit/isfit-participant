class LandingController < ApplicationController
  skip_before_filter :authenticate_user!, only: :index

  def index
    redirect_to dashboard_url and return if user_signed_in?
    @user = User.new
  end
end
