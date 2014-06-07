class DialogueApplicationsController < ApplicationController
  def show
    @dialogue_application = DialogueApplication.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dialogue_application }
    end
  end

  def new
    @dialogue_application = DialogueApplication.new
  end

  # GET /dialogue_applications/1/edit
  def edit
    @dialogue_application = DialogueApplication.find(params[:id])
  end

  def create
    @dialogue_application = DialogueApplication.new(params[:dialogue_application])
    @dialogue_application.user_id = params[:user_id]

    if @dialogue_application.save
      redirect_to dashboard, notice: 'Dialogue application was successfully saved. You can edit it until the 30th of september.'
    else
      render action: "new"
    end
  end

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

  def destroy
    @dialogue_application = DialogueApplication.find(params[:id])
    @dialogue_application.destroy

    respond_to do |format|
      format.html { redirect_to dialogue_applications_url }
      format.json { head :no_content }
    end
  end
end
