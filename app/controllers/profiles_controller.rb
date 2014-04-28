class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(params[:profile])
    @profile.user_id = params[:user_id]

    if @profile.save
      redirect_to dashboard_url, notice: 'Your profile was successfully created. We can\'t wait for your application!'
    end
  end
end
