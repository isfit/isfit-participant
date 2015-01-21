class Admin::UsersController < ApplicationController
  before_filter :set_user, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  def index
    @users = User.paginate(page: params[:page]).order(:first_name)
    @users = @users.where(role: params[:role]) if params[:role].present?

    if params[:search].present?
      keyword = "%#{params[:search]}%"
      @users = @users.where("first_name LIKE ? OR last_name LIKE ? OR email=?", keyword, keyword, params[:search])
    end
  end

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def create
    @user = User.new(params[:user])
    @user.role = params[:user][:role]

    if @user.save
      redirect_to admin_users_path, notice: 'User was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @user.role = params[:user][:role]

    if @user.update_attributes(params[:user])
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
     render action: "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_url
  end

  def dequeue
    @workshops = Workshop.all
    render layout: 'application_dashboard'
  end

  def dequeue_update 
    @workshops = Workshop.all

    begin
      @user = User.find(params[:dequeue_user_id])
      @workshop = Workshop.find(params[:dequeue_workshop_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'Selected user or workshop is not valid'
      render :dequeue, layout: 'application_dashboard' and return
    end

    unless @user.workshop_application.status == 4
      flash[:alert] = 'Selected user is not on waiting list'
      render :dequeue, layout: 'application_dashboard' and return
    end

    # Update user attributes
    @user.role = 'participant'
    @user.active = 1
    @user.save

    # Make a participant
    participant = Participant.create(
      workshop_id: params[:dequeue_workshop_id], 
      accepted_invitation: 1,
      user_id: @user.id,
      need_visa: 0,
      approved_first_deadline: 1,
      approved_second_deadline: 2,
      approved_third_deadline: 2)

    # Workshop application update
    @user.workshop_application.status = 1
    @user.workshop_application.save

    # Redirect
    flash[:notice] = "#{@user.full_name} is now a participant"
    redirect_to dequeue_admin_users_url
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end