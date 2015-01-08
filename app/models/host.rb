class Host < ActiveRecord::Base
   attr_accessible 	:id,	:firstname,	:lastname,	:address,	:zipcode,	:city,	:phone,	:capacity,	:comments,	:email,	:beenhost,	:sex,	:isstudent,	:animales,	:sleeping,	:extraday,	:deleted
end
