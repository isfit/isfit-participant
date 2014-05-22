class DialogueApplicationsController < ApplicationController
  # GET /dialogue_applications/1
  # GET /dialogue_applications/1.json
  def show
    @dialogue_application = DialogueApplication.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dialogue_application }
    end
  end

  # GET /dialogue_applications/new
  # GET /dialogue_applications/new.json
  def new
    @dialogue_application = DialogueApplication.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dialogue_application }
    end
  end

  # GET /dialogue_applications/1/edit
  def edit
    @dialogue_application = DialogueApplication.find(params[:id])
  end

  # POST /dialogue_applications
  # POST /dialogue_applications.json
  def create
    @dialogue_application = DialogueApplication.new(params[:dialogue_application])

    respond_to do |format|
      if @dialogue_application.save
        format.html { redirect_to @dialogue_application, notice: 'Dialogue application was successfully created.' }
        format.json { render json: @dialogue_application, status: :created, location: @dialogue_application }
      else
        format.html { render action: "new" }
        format.json { render json: @dialogue_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dialogue_applications/1
  # PUT /dialogue_applications/1.json
  def update
    @dialogue_application = DialogueApplication.find(params[:id])

    respond_to do |format|
      if @dialogue_application.update_attributes(params[:dialogue_application])
        format.html { redirect_to @dialogue_application, notice: 'Dialogue application was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dialogue_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dialogue_applications/1
  # DELETE /dialogue_applications/1.json
  def destroy
    @dialogue_application = DialogueApplication.find(params[:id])
    @dialogue_application.destroy

    respond_to do |format|
      format.html { redirect_to dialogue_applications_url }
      format.json { head :no_content }
    end
  end
end
