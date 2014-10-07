class User < ActiveRecord::Base
  ROLES = [
    ['Applicant', 'applicant'],
    ['Dialogue functionary', 'functionary-dialogue'],
    ['Participant functionary', 'functionary-participant'],
    ['Workshop functionary', 'functionary-workshop'],
    ['Admin', 'admin']
  ]

  # Attributes
  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :first_password, :first_name, :last_name,
                  :profile_attributes

  # Relations
  has_one :participant
  has_one :profile

  has_one :dialogue_application
  has_one :workshop_application

  has_and_belongs_to_many :deadlines

  accepts_nested_attributes_for :profile

  # Validations
  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true

  # Other crap
  devise :database_authenticatable, 
         :recoverable, :registerable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  self.per_page = 15

  # Whay you say? Functions!
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def is_participant?
    if self.participant
      true
    else
      false
    end
  end
  def self.roles
    ROLES
  end
end
