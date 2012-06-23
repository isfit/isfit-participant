class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role? :admin
      can :manage, :all
    end
    if user.role? :functionary
      can :read, Article
    end
    if user.role? :participant
      can :read, Article
    end
    if user.role? :dialogue
      #
    end
    if user.role? :sec
      #
    end
  end

end
