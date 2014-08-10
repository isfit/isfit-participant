class Settings::PasswordController < ApplicationController
  before_filter :set_user

  def edit
  end

  def update
    if @user.update_with_password(params[:user])
      sign_in @user, :bypass => true
      redirect_to settings_edit_password_url, notice: 'Your password was successfully changed.'
    else
      render :edit
    end
  end

  private
    def set_user
      @user = current_user
    end
end
