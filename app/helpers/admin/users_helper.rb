module Admin::UsersHelper
  def get_role_options(selected)
    roles = if can? :manage, User
      User::ROLES
    else
      User::ROLES_RESTRICTED
    end

    roles.unshift(['Select role', nil])

    options_for_select(roles, selected: selected)
  end
end
