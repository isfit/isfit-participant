class ApplyController < Devise::RegistrationsController
  before_filter 

  def build_resource(hash=nil)
    super(hash)
    self.resource.build_profile if resource.profile.nil?
  end

  def after_sign_up_path_for(resource)
    if self.resource.profile.related_to_conflict_area?
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