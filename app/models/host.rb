class Host < ActiveRecord::Base
   attr_accessible 	:id,	:firstname,	:lastname,	:address,	:zipcode,	:city,	:phone,	:capacity,	:comments,	:email,	:beenhost,	:sex,	:isstudent,	:animales,	:sleeping,	:extraday,	:deleted
   has_many :participants
   self.primary_key = :id
   def has_free_beds?
     if self.capacity.nil?
      return false
     end
     if self.get_free_beds > 0
       return true
     else
       return false
     end
   end
  def get_free_beds
    if self.capacity.nil?
      return 0
    end
    num_locked = 0
    self.participants.each do |p|
      if !p.host_id.nil?
        num_locked += 1
      end
    end
    self.capacity - num_locked
  end
  def self.get_all_free_beds
    total = 0
    #Host.get_all_non_deleted.each do |h|
      #total += h.capacity
    #end
    total
  end
  def self.get_all_non_deleted
    Host.where('deleted != 1 OR deleted IS NULL')
  end
end
