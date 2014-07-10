class RolesController < ApplicationController
  load_and_authorize_resource

  # GET /users
  def index
    search_role
    @users = User.where(@query).paginate(:per_page => 25, :page=>params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @roles = Array.new
    Role.all.each do |r|
      @roles.push(r.name)
    end
    @selectedroles = Array.new
    @user.roles.each do |r|
      @selectedroles.push(r.name)
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    roles = params[:role]
    if roles
      @user.roles.each do |r|
        found = false
        roles.each do |s|
          if s == r.name
            found = true
          end
        end
        if !found
          @user.roles.delete(r)
        end
      end
      roles.each do |r|
        role = Role.find(:first, :conditions=>{:name=>r})
        if !@user.roles.include?(role)
          @user.roles << role
        end
      end
    else
      @user.roles.each do |r|
        @user.roles.delete(r)
      end
    end
    respond_to do |format|
      if params[:user][:password] == ""
        params[:user].delete(:password)
      end
      if @user.update_attributes(params[:user])
        format.html { redirect_to(role_path(@user), :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])

    @user.destroy
    
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def search_role
    @query = ""
    
    if params[:user]
       @search_role = User.new(params[:user])
       email = @search_role.email
      if email !=""
        if @query == ""
          @query = "email LIKE '%"+email+"%'"
        else
          @query += " AND email LIKE '%"+email+"%'"
        end
      end 
    end
  end
end
