class DialogueApplicationsController < ApplicationController

  def index
	 @dialogue_applications = DialogueApplication.all
  end
  
end
