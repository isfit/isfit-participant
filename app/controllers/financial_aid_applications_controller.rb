class FinancialAidApplicationsController < ApplicationController
  before_filter :authenticate_user!
  # GET /financial_aid_applications
  # GET /financial_aid_applications.json
  def index
    @financial_aid_applications = FinancialAidApplication.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @financial_aid_applications }
    end
  end

  # GET /financial_aid_applications/1
  # GET /financial_aid_applications/1.json
  def show
    @financial_aid_application = FinancialAidApplication.where(user_id: params[:user_id]).first

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @financial_aid_application }
    end
  end

  # GET /financial_aid_applications/new
  # GET /financial_aid_applications/new.json
  def new
    @financial_aid_application = FinancialAidApplication.new
    @user = User.find(params[:user_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @financial_aid_application }
    end
  end

  # GET /financial_aid_applications/1/edit
  def edit
    @user = User.find(params[:user_id])
    @financial_aid_application = @user.financial_aid_application
  end

  # POST /financial_aid_applications
  # POST /financial_aid_applications.json
  def create
    @financial_aid_application = FinancialAidApplication.new(params[:financial_aid_application])
    @financial_aid_application.user_id = params[:user_id]
    @user = User.find(params[:user_id])

      if @financial_aid_application.save
        #redirect_to user_financial_aid_application_path(params[:user_id]), notice: 'Financial aid application was successfully created.'
        redirect_to dashboard_url, notice: 'Your financial aid application was saved'
      else
        render action: "new"
      end
  end

  # PUT /financial_aid_applications/1
  # PUT /financial_aid_applications/1.json
  def update
    @financial_aid_application = FinancialAidApplication.where(user_id: params[:user_id]).first

      if @financial_aid_application.update_attributes(params[:financial_aid_application])
        redirect_to dashboard_url, notice: 'Your financial aid application was updated'
      else
        @user = User.find(params[:user_id])
        render action: "edit"
      end
  end

  # DELETE /financial_aid_applications/1
  # DELETE /financial_aid_applications/1.json
  def destroy
    @financial_aid_application = FinancialAidApplication.find(params[:id])
    @financial_aid_application.destroy

    respond_to do |format|
      format.html { redirect_to financial_aid_applications_url }
      format.json { head :no_content }
    end
  end
end
