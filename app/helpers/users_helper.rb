module UsersHelper
  def roles_to_sentence(user)
    role_names = []
    user.roles.each { |r| role_names << r.name.titleize }

    role_names.to_sentence
  end
end
