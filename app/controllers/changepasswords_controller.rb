class ChangepasswordsController < ApplicationController

  access_control do
    allow :admin
    allow :functionary
    allow :participants
  end



  def edit_password
    @user = current_user
  end

  def update_password
    @user = current_user
    password = params[:password]
    if password != params[:password_confirmation] or password == ""
      @user.errors.add(:password, " and Password confirmation does not match")
      render :action => "edit_password"
    else
      @user.password = password
      respond_to do |format|
        if @user.save
          format.html { redirect_to(root_path, :notice => 'Password was successfully changed.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit_password" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      end
    end 
  end
end
