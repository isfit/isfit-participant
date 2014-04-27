class RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new(params[:user])
    applicant_role = Role.where(name: 'applicant')

    if @user.save
      @user.roles << applicant_role
      sign_in @user
      redirect_to dashboard_url, :notice => 'Your profile was successfully created. We can\'t wait for your application!'
    else
      params[:user][:password] = nil
      params[:user][:password_confirmation] = nil
      render action: 'new'
    end
  end
end
