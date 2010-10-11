class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  # roles
  acts_as_authorization_subject  :association_name => :roles
  
  #relations
  has_one :participant
  has_one :functionary

  #methods
  def name
    user = self.functionary
    if user == nil
      user = self.participant
    end
    user.first_name
  end
  def is_functionary?
    if self.functionary
      true
    else
      false
    end
  end
  def is_participant?
    if self.functionary
      true
    else
      false
    end
  end
end
