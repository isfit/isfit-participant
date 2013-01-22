class Functionary < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :participants

  def self.all_with_role_functionary
  	self.includes(:user => :roles).all
      .select{ |f| f.user.has_role?(:functionary) }
  		.collect{ |f| [f.first_name + " " + f.last_name, f.id] }
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
