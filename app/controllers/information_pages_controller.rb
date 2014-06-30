class InformationPagesController < ApplicationController
  load_and_authorize_resource

  # GET /information_pages
  # GET /information_pages.xml
  def index
    @information_pages = InformationPage.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @information_pages }
    end
  end

  # GET /information_pages/1
  # GET /information_pages/1.xml
  def show
    @information_page = InformationPage.find(params[:id])
    @categories = InformationCategory.all
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @information_page }
    end
  end

  # GET /information_pages/new
  # GET /information_pages/new.xml
  def new
    @information_page = InformationPage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @information_page }
    end
  end

  # GET /information_pages/1/edit
  def edit
    @information_page = InformationPage.find(params[:id])
  end

  # POST /information_pages
  # POST /information_pages.xml
  def create
    @information_page = InformationPage.new(params[:information_page])
    @information_page.user_id = current_user.id

    respond_to do |format|
      if @information_page.save
        format.html { redirect_to(@information_page, :notice => 'Information page was successfully created.') }
        format.xml  { render :xml => @information_page, :status => :created, :location => @information_page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @information_page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /information_pages/1
  # PUT /information_pages/1.xml
  def update
    @information_page = InformationPage.find(params[:id])

    respond_to do |format|
      if @information_page.update_attributes(params[:information_page])
        format.html { redirect_to(@information_page, :notice => 'Information page was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @information_page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /information_pages/1
  # DELETE /information_pages/1.xml
  def destroy
    @information_page = InformationPage.find(params[:id])
    @information_page.destroy

    respond_to do |format|
      format.html { redirect_to(information_pages_url) }
      format.xml  { head :ok }
    end
  end
end
