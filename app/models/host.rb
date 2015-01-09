class Host < ActiveRecord::Base
   attr_accessible 	:id,	:firstname,	:lastname,	:address,	:zipcode,	:city,	:phone,	:capacity,	:comments,	:email,	:beenhost,	:sex,	:isstudent,	:animales,	:sleeping,	:extraday,	:deleted
   has_many :participants
   self.primary_key = :id
   def has_free_beds?
     if self.capacity.nil?
      return false
     end
     if self.participants.count < self.capacity
       return true
     else
       return false
     end
   end
  def get_free_beds
    self.capacity - self.participants.count
  end
end
