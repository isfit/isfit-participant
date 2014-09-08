module DashboardHelper
  def current_user_has_complete_dialoge_application?
    return false unless current_user_can_apply_for_dialogue?
    return false unless current_user.dialogue_application

    current_user.dialogue_application.complete?
  end

  def current_user_has_created_dialogue_application?
    return false unless current_user_can_apply_for_dialogue?

    current_user.dialogue_application
  end

  def current_user_can_apply_for_dialogue?
    current_user.profile.lives_in_conflict_area? || current_user.profile.citizenship_in_conflict_area?
  end
end
