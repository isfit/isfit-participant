class ProfilesController < ApplicationController
  before_filter :check_if_can_manage_user, :check_for_existing_profile

  def new
    @profile = Profile.new
    @user = User.find(params[:user_id])
  end

  def create
    @profile = Profile.new(params[:profile])
    @profile.user_id = params[:user_id]
    @user = User.find(params[:user_id])

    if @profile.save
      redirect_to dashboard_url, notice: 'Your profile was successfully created. We can\'t wait for your application!'
    else
      render action: 'new'
    end
  end

  private
    def check_for_existing_profile
      redirect_to dashboard_url, alert: 'You already have a profile!' if User.find(params[:user_id]).profile
    end
end
