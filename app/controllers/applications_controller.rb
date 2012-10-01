class ApplicationsController < ApplicationController

  load_and_authorize_resource
  
  def index
    @applications = Application.where("deleted = 0")
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def grade1
    if !ControlPanel.first.app_grade1
      return redirect_to applications_path, alert: "You are not able to view this page at the moment"
    end
    @selected_applications = Application.where("deleted = 0 AND (grade1_functionary_id = ? AND grade1 = 0)", current_user.id)
    @applications = Application.where("deleted = 0 AND grade1_functionary_id = 0").order("rand()").limit(30)
    @grade = 1
    @workshops = Workshop.all
    @app_not_graded = ((Application.where("deleted = 0 AND grade1 = 0").count.to_f / Application.where("deleted = 0").count.to_f) * 100).to_i
    @app_graded = 100 - @app_not_graded

    respond_to do |format|
      format.html # index.html.erb
    end 
  end

  def grade2
    if !ControlPanel.first.app_grade2
      return redirect_to applications_path, alert: "You are not able to view this page at the moment"
    end 
    @selected_applications = Application.where("deleted = 0 AND (grade2_functionary_id = ? AND grade2 = 0)", current_user.id)
    @applications = Application.where("deleted = 0 AND grade2_functionary_id = 0").order("rand()").limit(30)
    @grade = 2 
    @workshops = Workshop.all
    @app_not_graded = ((Application.where("deleted = 0 AND grade2 = 0").count.to_f / Application.where("deleted = 0").count.to_f) * 100).to_i
    @app_graded = 100 - @app_not_graded

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def selection
    if !ControlPanel.first.app_grade3
      return redirect_to applications_path, alert: "Selection of applications is not open at the moment"
    end
    @application = Application.find(params[:id])
    @workshops = Workshop.all
    @status = { "Not processed" => 0,
      "Accepted" => 1,
      "Not accepted" => 2,
      "Waiting list" => 3}
  end

  def save_selection
    if !ControlPanel.first.app_grade3
      return redirect_to applications_path, alert: "Selection of applications is not open at the moment"
    end

    @application.selection_functionary_id = current_user.id
    @application.status = params[:application][:status]
    @application.final_workshop = params[:application][:final_workshop]
    @application.selection_comment = params[:application][:selection_comment]
    @application.travel_approved = params[:application][:travel_approved]
    @application.travel_amount_given = params[:application][:travel_amount_given]
    @application.travel_comment = params[:application][:travel_comment]
 
    if @application.save
      redirect_to stats_applications_path, notice: 'Application was successfully saved.'
    else
      redirect_to selection_application_path, alert: 'Something went wrong.'
    end
  end

  def show
    @application = Application.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def select_app
    @application = Application.find(params[:id])
    if can?(:grade1, Application) && params[:grade].to_i == 1 && ControlPanel.first.app_grade1
      if @application.grade1_functionary_id == 0 
        @application.grade1_functionary_id = current_user.id
      else
        return redirect_to grade1_applications_path, alert: "Application is allready selected."
      end
    elsif can?(:grade2, Application) && params[:grade].to_i == 2 && ControlPanel.first.app_grade2 
      if @application.grade2_functionary_id == 0
        @application.grade2_functionary_id = current_user.id
      else
        return redirect_to grade2_applications_path, alert: "Application is allready selected."
      end
    else
      return redirect_to root_path, alert: "You don't have permission to select applications."
    end
    respond_to do |format|
      if @application.save
        format.html { redirect_to grade_app_application_path, notice: 'Application was successfully selected.' }
      else
        format.html { redirect_to @application, alert: 'Something went wrong.' }
      end
    end
  end

  def grade_app
    @application = Application.find(params[:id])
  end

  def set_grade
    @application = Application.find(params[:id])
    if @application.grade1_functionary_id == current_user.id && @application.grade1 == 0 && ControlPanel.first.app_grade1
      @application.grade1 = params[:application][:grade1]
      @application.grade1_comment = params[:application][:grade1_comment]
      @application.total_grade = @application.grade1 + @application.grade2
      if @application.save
        redirect_to grade1_applications_path, notice: 'Grade was successfully set.'
      else
        redirect_to grade_app_application_path, alert: 'Something went wrong.'
      end
    elsif @application.grade2_functionary_id == current_user.id && @application.grade2 == 0 && ControlPanel.first.app_grade2 
      @application.grade2 = params[:application][:grade2]
      @application.grade2_comment = params[:application][:grade2_comment]
      @application.total_grade = @application.grade1 + @application.grade2
      if @application.save
        redirect_to grade2_applications_path, notice: 'Grade was successfully set.'
      else
        redirect_to grade2_application_path, alert: 'Something went wrong.'
      end
    else
      redirect_to applications_path, alert: "You was not able to set a grade for this application."
    end
  end
  
  def new
    @application = Application.new
    @countries = Country.all
    @workshops = Workshop.all

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @application = Application.find(params[:id])
    @countries = Country.all
    @workshops = Workshop.all
  end

  def create
    @application = Application.new(params[:application])

    respond_to do |format|
      if @application.save
        format.html { redirect_to @application, notice: 'Application was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @application = Application.find(params[:id])

    respond_to do |format|
      if @application.update_attributes(params[:application])
        format.html { redirect_to @application, notice: 'Application was successfully updated.' }
      else
        @countries = Country.all
        @workshops = Workshop.all
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @application = Application.find(params[:id])
    @application.deleted = 1
    @application.save

    respond_to do |format|
      format.html { redirect_to applications_url }
      format.json { head :no_content }
    end
  end

  def search
    @q = Application.search(params[:q])
    @applications = @q.result.where("deleted = 0")
    @countries = Country.all
    @workshops = Workshop.all
    @status = { "Not processed" => 0,
      "Accepted" => 1,
      "Not accepted" => 2,
      "Waiting list" => 3}
  end

  def stats
    @q = Application.search(params[:q])
    @applications = @q.result.where("deleted = 0")
    @countries = Country.all
    @workshops = Workshop.all
    @status = { "Not processed" => 0,
      "Accepted" => 1,
      "Not accepted" => 2,
      "Waiting list" => 3 }

    @participants_gender = @applications.group("sex").count
    @participants_age = @applications.count(:group => "year(birthdate)")
    @country_count = @applications.group("country_id").count
    @workshop1_count = @applications.group("workshop1").count
    @workshop2_count = @applications.group("workshop2").count
    @workshop3_count = @applications.group("workshop3").count
    @countries = Country.where("code IS NOT NULL")
  end
end
