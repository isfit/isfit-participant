class UsersController < ApplicationController
  before_filter :authenticate_user!

  load_and_authorize_resource

  def index
    @users = User.where(active: true)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  def register

  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.active = false
    @user.save

    redirect_to users_path
  end

  def add_role
    @user = User.find(params[:id])
    @role = Role.find(params[:role][:id])

    unless @user.has_role?(@role.name)
      @user.roles << @role
    end

    render json: @user.roles.to_json
  end

  def remove_role
    @user = User.find(params[:id])
    @role = Role.find(params[:role])

    if @user.has_role?(@role.name)
      UserRole.find_by_user_id_and_role_id(@user.id, @role.id).destroy
    end

    render json: User.find(params[:id]).roles.to_json
  end
end
