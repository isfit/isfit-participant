class DialogueApplicationsController < ApplicationController

  def index
	 @dialogue_applications = DialogueApplication.all
  end

  def new
  	@dialogue_applications.new
  end

  def show
  	@dialogue_application = DialogueApplication.find(params[:id])
  end

  def destroy
  	@dialogue_applications.destroy
  	redirect_to dialogue_applications_url
  end


  
end
