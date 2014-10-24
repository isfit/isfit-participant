class WorkshopApplicationsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @applications = WorkshopApplication.valid

    if params[:name].present?
      keyword = "%#{params[:name]}%"
      @applications = @applications.
        where('users.first_name LIKE ? OR users.last_name LIKE ?', keyword, keyword)
    end

    @applications = @applications.paginate(page: params[:page]).
      order('users.first_name ASC', 'users.last_name ASC')
  end
end

