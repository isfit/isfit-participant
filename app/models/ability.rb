class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 'admin'
      can :manage, :all
    end

    if user.role == 'applicant'
      can [:show, :edit, :update], User
      can [:new, :create, :edit, :update], DialogueApplication
    end
  end
end
