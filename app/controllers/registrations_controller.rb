class RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new(params[:user])
    applicant_role = Role.where(name: 'applicant')

    if @user.save
      @user.roles << applicant_role
      sign_in @user
      redirect_to new_user_profile_path(@user), :notice => 'Your account was successfully created. To complete the process please create a profile!'
    else
      params[:user][:password] = nil
      params[:user][:password_confirmation] = nil
      render action: 'new'
    end
  end
end
