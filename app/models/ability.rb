class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role? :admin
      can :manage, :all
    end

    if user.has_role? :functionary
      can :read, Article
      can :show, InformationPage
      can [:index, :show, :update, :q_status, :resolve], Question
      can :read, Workshop
      can [:show, :edit, :update], User
    end

    if user.has_role? :theme
      can [:index, :show, :participants, :attendance_list], Workshop
      can [:show, :edit, :update], User
    end

    if user.has_role? :participant
      can :read, Article
      can :show, InformationPage
      can :show, Workshop
      can [:index, :new, :create], Question
      can [:show, :edit, :update], User
    end

    if user.has_role? :functionary_support
      can [:show, :edit, :update], User
    end

    if user.has_role? :dialogue
      can [:show, :edit, :update], User
    end

    if user.has_role? :sec
      can :manage, Host
      can [:participants, :attendance_list, :index, :show], Workshop
      can [:index, :match, :match_host, :remove_host, :check_in, :check_out, :show, :add_phone_number, :update_phone_number, :remove_check_in], Participant
      can [:show, :edit, :update], User
    end

    if user.has_role? :applicant
      can [:show, :edit, :update], User
      can [:new, :create, :edit, :update], DialogueApplication
    end
  end
end
