class ApplyController < Devise::RegistrationsController
  def new
    if DateTime.current > DateTime.new(2014, 10, 15, 0, 0, 0, '+02:00')
      redirect_to root_url and return
    end

    super
  end

  def create
    if DateTime.current > DateTime.new(2014, 10, 15, 1, 0, 0, '+02:00')
      redirect_to root_url and return
    end

    super
  end

  def build_resource(hash=nil)
    super(hash)
    self.resource.build_profile if resource.profile.nil?
  end

  def after_sign_up_path_for(resource)
    if self.resource.profile.related_to_conflict_area? or self.resource.profile.user.is_late_recruited?
      dashboard_url
    else
      new_applications_workshop_url
    end
  end

  private
    def redirect_if_signed_in
      redirect_to dashboard_url if user_signed_in?
    end
end