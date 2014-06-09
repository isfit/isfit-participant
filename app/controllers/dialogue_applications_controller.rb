class DialogueApplicationsController < ApplicationController
  before_filter :load_user, :can_access_dialogue_application, :check_user_profile, :check_user_country, only: [:new, :create, :edit, :update]
  before_filter :authenticate_user!

  load_and_authorize_resource

  def show
    @dialogue_application = DialogueApplication.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dialogue_application }
    end
  end

  def new
    if @user.dialogue_application
      redirect_to dashboard_url, notice: 'You can\'t create a new dialogue application since you already have one!'
    end

    @dialogue_application = DialogueApplication.new
  end

  def edit
    @dialogue_application = DialogueApplication.where(user_id: params[:user_id]).first
  end

  def create
    @dialogue_application = DialogueApplication.new(params[:dialogue_application])
    @dialogue_application.user_id = params[:user_id]

    if @dialogue_application.save
      redirect_to dashboard_url, notice: 'Dialogue application was successfully saved. You can edit it until the 30th of september.'
    else
      render action: "new"
    end
  end

  def update
    @dialogue_application = DialogueApplication.where(user_id: params[:user_id]).first

    if @dialogue_application.update_attributes(params[:dialogue_application])
      redirect_to edit_user_dialogue_application_url(params[:user_id]), notice: 'Changes for your dialogue application is saved.'
    else
      render action: "edit"
    end
  end

  def destroy
    @dialogue_application = DialogueApplication.find(params[:id])
    @dialogue_application.destroy

    respond_to do |format|
      format.html { redirect_to dialogue_applications_url }
      format.json { head :no_content }
    end
  end

  private
    def load_user
      @user = User.find(params[:user_id])
    end

    def can_access_dialogue_application
      unless current_user == @user or (can? :manage, DialogueApplication)
        return redirect_to dashboard_url, alert: 'You are not authorized for that action!'
      end
    end

    def check_user_profile
      unless @user.profile
        return redirect_to dashboard_url, alert: 'User need a profile before workshop application can be filled.'
      end 
    end

    def check_user_country
      unless @user.profile.country_id == 41
        return redirect_to dashboard_url, alert: 'User must be from the selected conflict area before sending workshop application.'
      end
    end
end
