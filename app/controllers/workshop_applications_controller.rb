class WorkshopApplicationsController < ApplicationController

def index
	@workshop_applications = WorkshopApplication.all
end



def show
	@workshop_applications = WorkshopApplication.find(params[:id])
end

def new 
	@workshop_application = WorkshopApplication.new
end


end 