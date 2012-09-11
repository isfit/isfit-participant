class Application < ActiveRecord::Base
  attr_accessible :address, :birthdate, :city, :country_id, :email, :essay1, 
    :essay2, :field_of_study, :first_name, :last_name, :phone, :sex, 
    :travel_amount, :travel_apply, :travel_essay, :travel_nosupport_cancome, 
    :travel_nosupport_other, :university, :workshop1, :workshop2, :workshop3, 
    :zipcode, :grade1_functionary_id, :grade1, :grade1_comment, 
    :grade2_functionary_id, :grade2, :grade2_comment, :grade3_functionary_id, 
    :grade3, :grade3_comment, :travel_functionary_id, :travel_approved, 
    :travel_amount_given, :travel_comment, :status, :final_workshop, :deleted
  
  belongs_to :country
  has_and_belongs_to_many :functionaries
 
end
