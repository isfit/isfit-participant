class Settings::UserController < ApplicationController
  before_filter :set_user

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to settings_edit_user_url, notice: 'Your user was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
    def set_user
      @user = current_user
    end
end
