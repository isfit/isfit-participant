class Deadline < ActiveRecord::Base
  has_and_belongs_to_many :users

  def self.deadline_done?(name,current_user)
    return Deadline.find(:first, :conditions=>"name='"+name+"'").users.include?(current_user)   
  end
end
