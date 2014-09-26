class LandingController < ApplicationController
  skip_before_filter :authenticate_user!, only: :index

  def index
    if user_signed_in?
      redirect_to dashboard_url
    else
      redirect_to new_user_registration_url
    end
  end
end
