class Admin::UsersController < ApplicationController
  before_filter :set_user, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def create
    @user= User.new(params[:user])

    if @user.save
      redirect_to admin_users_path, notice: 'User was successfully created.'
    else
      render action: "new"
    end
  end

  def update
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