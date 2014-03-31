class Functionary < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user
  has_and_belongs_to_many :participants

  def self.all_with_role_functionary
  	self.includes(:user => :roles).all
      .select{ |f| f.user.nil? ? nil : f.user.has_role?(:functionary) }
  		.collect{ |f| [f.first_name + " " + f.last_name, f.id] }
  end

  def full_name
    "#{user.first_name} #{user.last_name}"
  end

  def first_name
    user.first_name
  end

  def last_name
    user.last_name
  end

  def email
    user.email
  end
end
