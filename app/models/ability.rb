class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role? :admin
      can :manage, :all
    end
    if user.has_role? :functionary
      can :read, Article
      can [:update, :show], Functionary
      can :show, InformationPage
      can [:read, :update, :travel_support, :invitation, :validate_deadline, :check_deadline, :approve_deadline, :failed_deadline, :remove_deadline, :ignore, :unignore], Participant
      can [:index, :show, :update, :q_status, :resolve], Question
      can :read, Workshop
      can [:index, :show, :update, :grade1, :select_app, :grade_app, :set_grade], Application
    end
    if user.has_role? :theme
      can [:index, :show, :grade2, :select_app, :grade_app, :set_grade], Application
    end
    if user.has_role? :participant
      can :read, Article
      can :show, InformationPage
      can :show, Workshop
      can [:index, :new, :create], Question
      if user.is_participant?
        can [:show, :update, :travel_support, :invitation, :letter_of_recommendation, :deadlines, :deadlines_handler], Participant, id: user.participant.id
        can [:show, :update], Question, participant_id: user.participant.id
      end
    end
    if user.has_role? :functionary_support
      can  [:search, :create], Application
    end
    if user.has_role? :dialogue
      can [:read, :search], Application
    end
    if user.has_role? :sec
      can :manage, Host
      can [:index, :match, :match_host, :check_in, :check_out, :show], Participant
    end
  end

end
