class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 'admin'
      can :manage, :all
    end

    if user.role == 'functionary-dialogue'
      can :manage, :dialogue_application
    end
  end
end
