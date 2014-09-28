class DialogueApplicationsController < ApplicationController
  load_and_authorize_resource
  
  def index
	 @dialogue_applications = DialogueApplication.paginate(page: params[:page])
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
