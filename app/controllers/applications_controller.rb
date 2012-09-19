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
      return redirect_to applications_path, notice: "You are not able to view this page at the moment"
    end
    @selected_applications = Application.where("deleted = 0 AND (grade1_functionary_id = ? AND grade1 = 0)", current_user.id)
    @applications = Application.where("deleted = 0 AND grade1_functionary_id = 0")
    @grade = 1
    @workshops = Workshop.all

    respond_to do |format|
      format.html # index.html.erb
    end 
  end

  def grade2
    if !ControlPanel.first.app_grade2
      return redirect_to applications_path, notice: "You are not able to view this page at the moment"
    end 
    @selected_applications = Application.where("deleted = 0 AND (grade2_functionary_id = ? AND grade2 = 0)", current_user.id)
    @applications = Application.where("deleted = 0 AND grade2_functionary_id = 0") # Add only access for workshop leader
    @grade = 2 
    @workshops = Workshop.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def grade3
    if !ControlPanel.first.app_grade3
      return redirect_to applications_path, notice: "You are not able to view this page at the moment"
    end
    @selected_applications = Application.where("deleted = 0 AND (grade3_functionary_id = ? AND grade3 = 0)", current_user.id)
    @applications = Application.where("deleted = 0 AND grade3_functionary_id = 0")
    @grade = 3
    @workshops = Workshop.all

    respond_to do |format|
      format.html # index.html.erb
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
    puts params[:grade] == 1
    if current_user.has_role?(:functionary) && params[:grade].to_i == 1 && ControlPanel.first.app_grade1
      if @application.grade1_functionary_id == 0 
        @application.grade1_functionary_id = current_user.id
      else
        return redirect_to grade1_application_path, notice: "Application is allready selected."
      end
    elsif current_user.has_role?(:theme) && params[:grade].to_i == 2 && ControlPanel.first.app_grade2 
      if @application.grade2_functionary_id == 0
        @application.grade2_functionary_id = current_user.id
      else
        return redirect_to applications_path, notice: "Application is allready selected."
      end
    elsif current_user.has_role?(:functionary) && params[:grade].to_i == 3 && ControlPanel.first.app_grade3 
      if @application.grade3_functionary_id == 0
        @application.grade3_functionary_id = current_user.id
      else
        return redirect_to grade3_application_path, notice: "Application is allready selected."
      end
    else
      return redirect_to applications_path, notice: "You don't have permission to select applications."
    end
    respond_to do |format|
      if @application.save
        format.html { redirect_to grade_app_application_path, notice: 'Application was successfully selected.' }
      else
        format.html { redirect_to @application, notice: 'Something went wrong :(' }
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
      if @application.save
        redirect_to grade1_applications_path, notice: 'Grade was successfully set.'
      else
        redirect_to grade1_application_path, warning: 'Something went wrong.'
      end
    elsif @application.grade2_functionary_id == current_user.id && @application.grade2 == 0 && ControlPanel.first.app_grade2 
      @application.grade2 = params[:application][:grade2]
      @application.grade2_comment = params[:application][:grade2_comment]
      if @application.save
        redirect_to grade2_applications_path, notice: 'Grade was successfully set.'
      else
        redirect_to grade2_application_path, warning: 'Something went wrong.'
      end
    elsif @application.grade3_functionary_id == current_user.id && @application.grade3 == 0 && ControlPanel.first.app_grade3 
      @application.grade3 = params[:application][:grade3]
      @application.grade3_comment = params[:application][:grade3_comment]
      if @application.save
        redirect_to grade3_applications_path, notice: 'Grade was successfully set.'
      else
        redirect_to grade3_application_path, warning: 'Something went wrong.'
      end
    else

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
    @search = Application.search(params[:q])
    @applications = @search.result
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
  end

  def stats

  end
end
