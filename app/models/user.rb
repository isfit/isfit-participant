class User < ActiveRecord::Base
  has_and_belongs_to_many :deadlines
  has_many :user_roles
  has_many :roles, :through => :user_roles

  validates_uniqueness_of :email
  
  validates_presence_of :email
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_password
  
  #relations
  has_one :participant
  has_one :functionary

  #methods
  def name
    user = self.functionary
    if user == nil
      user = self.participant
    end
    user.first_name + " " + user.last_name
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
