class Profile < ActiveRecord::Base
  validates_presence_of :date_of_birth, :gender, :nationality, :citizenship_id, :school, :field_of_study, :address, :postal_code, :city, :country_id,:calling_code, :phone
  attr_accessible :address, :calling_code, :citizenship_id, :city, :country_id, :date_of_birth, :field_of_study, :gender, :gender_specify, :nationality, :phone, :postal_code, :school, :motivation_essay
  belongs_to :user
end
