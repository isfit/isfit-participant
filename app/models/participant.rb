class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :arrival_place
  belongs_to :functionary
  has_many :questions
  belongs_to :transport_type
  
  #validations
  #validates_presence_of :first_name, :last_name, :email, :date_of_birth, :address1, :zipcode, :city, :field_of_study
  #validates_uniqueness_of :user_id
end
