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

  private
    def set_user
      @user = User.find(params[:id])
    end
end