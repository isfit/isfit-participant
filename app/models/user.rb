class User < ActiveRecord::Base
  ROLES = [
    ['Admin', 'admin'],
    ['Dialogue functionary', 'functionary-dialogue'],
    ['Participant functionary', 'functionary-participant'],
    ['Workshop functionary', 'functionary-workshop'],
    ['Participant', 'participant'],
    ['Applicant', 'applicant']
  ]

  ROLES_RESTRICTED = [
    ['Participant', 'participant'],
    ['Applicant', 'applicant']
  ]

  # Attributes
  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :first_password, :first_name, :last_name,
                  :profile_attributes, :workshop_id

  # Relations
  has_one :participant
  has_one :profile

  has_one :dialogue_application
  has_one :workshop_application

  accepts_nested_attributes_for :profile

  belongs_to :workshop

  has_many :questions
  has_many :owned_questions, class_name: 'Question', foreign_key: 'owner_id'

  has_many :answers

  has_many :countries
  
  # Validations
  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true

  # Other crap
  devise :database_authenticatable, 
         :recoverable, :registerable, :rememberable, :trackable, :validatable
  
  self.per_page = 15

  # Whay you say? Functions!
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def is_participant?
    if role == 'participant'
      true
    else
      false
    end
  end
  def is_late_recruited?
    if self.created_at > DateTime.new(2014, 10, 7, 1, 0, 0, '+02:00')
      true
    else
      false
    end
  end
  def active_for_authentication?
    super && self.active
  end
  def inactive_message
    'Your account has been deactivated'
  end
end
