class Profile < ActiveRecord::Base
  attr_accessible :address, :calling_code, :citizenship, :city, :country, :date_of_birth, :field_of_study, :gender, :gender_specify, :nationality, :phone, :postal_code, :school
  belongs_to :user
end
