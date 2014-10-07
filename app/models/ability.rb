class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 'admin'
      can :manage, :all
    end

    if user.role == 'functionary-dialogue'
      can :manage, DialogueApplication
    end

    if user.role == 'functionary-participant'
      can :manage, WorkshopApplication
    end
  end
end
