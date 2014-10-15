class WorkshopApplicationsController < ApplicationController

def index
	@workshop_applications = WorkshopApplication.paginate(page: params[:page])
end



def show
	@workshop_application = WorkshopApplication.find(params[:id])
end

def new 
	@workshop_applications = WorkshopApplication.new
end


end 