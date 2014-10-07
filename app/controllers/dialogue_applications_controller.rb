class DialogueApplicationsController < ApplicationController
  load_and_authorize_resource
  
  def index

    @countries = Country.all
    keyword = "%#{params[:name]}%"
   if params[:country].nil? == false && params[:country][:country_id].present? == true
     @dialogue_applications = DialogueApplication.joins(:profile).where('country_id = ? OR citizenship_id = ?',params[:country][:country_id], params[:country][:country_id]).where('first_name LIKE ? OR last_name LIKE ?', keyword, keyword).paginate(page: params[:page])
   elsif params[:name].present?
     @dialogue_applications = DialogueApplication.joins(:profile).where('first_name LIKE ? OR last_name LIKE ?', keyword, keyword).paginate(page: params[:page])
   else
     @dialogue_applications = DialogueApplication.paginate(page: params[:page])
   end
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
