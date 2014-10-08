class LandingController < ApplicationController
  skip_before_filter :authenticate_user!, only: :index

  def index
    if user_signed_in?
      redirect_to dashboard_url
    else
      if DateTime.current < DateTime.new(2014, 10, 1, 0, 0, 0, '+02:00')
        redirect_to new_user_registration_url
      end
      if DateTime.current < DateTime.new(2014, 10, 15, 0, 0, 0, '+02:00')
        @show_late = true
      end
    end
  end
end
