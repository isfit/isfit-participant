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
      can [:read, :update, :travel_support, :invitation, :isfit_transportation, :validate_deadline, :check_deadline, :approve_deadline, :ignore, :unignore, :search], Participant
      can [:index, :show, :update, :q_status, :resolve], Question
      can :read, Workshop
      can [:index, :show, :update, :grade1, :select_app, :grade_app, :set_grade], Application
      can [:show, :edit, :update], User
    end

    if user.has_role? :theme
      can [:index, :show, :grade2, :select_app, :grade_app, :set_grade], Application
      can [:index, :show, :participants, :attendance_list], Workshop
#      can [:show], Participant
#      can [:show], Host
      can [:show, :edit, :update], User
    end

    if user.has_role? :participant
      can :read, Article
      can :show, InformationPage
      can :show, Workshop
      can [:index, :new, :create], Question
      if user.is_participant?
        can [:show, :update, :travel_support, :invitation, :letter_of_recommendation, :isfit_transportation, :deadlines, :deadlines_handler], Participant, id: user.participant.id
        can [:show, :update], Question, participant_id: user.participant.id
      end
      can [:show, :edit, :update], User
    end

    if user.has_role? :functionary_support
      can  [:search, :create], Application
      can [:show, :edit, :update], User
    end

    if user.has_role? :dialogue
      can [:read, :search], Application
      can [:show, :edit, :update], User
    end

    if user.has_role? :sec
      can :manage, Host
      #cannot [:add_bed, :remove_bed], Host
      can [:participants, :attendance_list, :index, :show], Workshop
      can [:index, :match, :match_host, :remove_host, :check_in, :check_out, :show, :add_phone_number, :update_phone_number, :remove_check_in], Participant
      can [:show, :edit, :update], User
    end

    if user.has_role? :applicant
      can [:show, :edit, :update], User
      can [:new, :create], DialogueApplication
    end
  end
end
