class Admin::WorkshopsController < ApplicationController
  load_and_authorize_resource
  # GET /workshops
  # GET /workshops.json
  def index
    @workshops = Workshop.all


  end

  # GET /workshops/1
  # GET /workshops/1.json
  def show
    @workshop = Workshop.find(params[:id])

  end

  # GET /workshops/new
  # GET /workshops/new.json
  def new
    @workshop = Workshop.new

  end

  # GET /workshops/1/edit
  def edit
    @workshop = Workshop.find(params[:id])
  end

  # POST /workshops
  # POST /workshops.json
  def create
    @workshop = Workshop.new(params[:workshop])

    if @workshop.save
      redirect_to [:admin, @workshop], notice: 'Workshop was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /workshops/1
  # PUT /workshops/1.json
  def update
    @workshop = Workshop.find(params[:id])

    if @workshop.update_attributes(params[:workshop])
      redirect_to [:admin, @workshop], notice: 'Workshop was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /workshops/1
  # DELETE /workshops/1.json
  def destroy
    @workshop = Workshop.find(params[:id])
    @workshop.destroy
    redirect_to admin_workshops_url
  end
end
