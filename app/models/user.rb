class User < ActiveRecord::Base
  has_and_belongs_to_many :deadlines
  has_many :user_roles
  has_many :roles, :through => :user_roles
  has_one :profile

  accepts_nested_attributes_for :profile

  validate :emails_match, on: :create
  validates_uniqueness_of :email
  validates_presence_of :first_name, :last_name

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, 
         :recoverable, :registerable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :first_password, :first_name, :last_name,
                  :email_confirmation, :profile_attributes
  attr_accessor :email_confirmation
  
  #relations
  has_one :participant
  has_one :functionary

  #methods
  def full_name
    "#{first_name} #{last_name}"
  end

  def emails_match
    if (!self.email.eql? self.email_confirmation)
      errors.add(:email_confirmation, "must match email")
    end
  end

  def is_functionary?
    if self.functionary
      true
    else
      false
    end
  end
  
  def is_participant?
    if self.participant
      true
    else
      false
    end
  end

  def has_role?(role)
    roles.any? { |r| r[:name] == role.to_s }
  end
end
