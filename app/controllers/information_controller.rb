class InformationController < ApplicationController
  def index
    unless current_user.role == 'participant'
      redirect_to dashboard_url
    end
  end
end
