class InformationCategoriesController < ApplicationController
  # GET /information_categories
  # GET /information_categories.xml
  def index
    @information_categories = InformationCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @information_categories }
    end
  end

  # GET /information_categories/1
  # GET /information_categories/1.xml
  def show
    @information_category = InformationCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @information_category }
    end
  end

  # GET /information_categories/new
  # GET /information_categories/new.xml
  def new
    @information_category = InformationCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @information_category }
    end
  end

  # GET /information_categories/1/edit
  def edit
    @information_category = InformationCategory.find(params[:id])
  end

  # POST /information_categories
  # POST /information_categories.xml
  def create
    @information_category = InformationCategory.new(params[:information_category])

    respond_to do |format|
      if @information_category.save
        format.html { redirect_to(@information_category, :notice => 'Information category was successfully created.') }
        format.xml  { render :xml => @information_category, :status => :created, :location => @information_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @information_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /information_categories/1
  # PUT /information_categories/1.xml
  def update
    @information_category = InformationCategory.find(params[:id])

    respond_to do |format|
      if @information_category.update_attributes(params[:information_category])
        format.html { redirect_to(@information_category, :notice => 'Information category was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @information_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /information_categories/1
  # DELETE /information_categories/1.xml
  def destroy
    @information_category = InformationCategory.find(params[:id])
    @information_category.destroy

    respond_to do |format|
      format.html { redirect_to(information_categories_url) }
      format.xml  { head :ok }
    end
  end
end
