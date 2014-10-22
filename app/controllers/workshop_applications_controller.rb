class WorkshopApplicationsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @applications = WorkshopApplication.valid.paginate(page: params[:page]).
      order('users.first_name ASC', 'users.last_name ASC')
  end
end

