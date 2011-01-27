class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :arrival_place
  has_and_belongs_to_many :functionaries
  has_many :questions
  belongs_to :transport_type
  belongs_to :country
  belongs_to :workshop
  belongs_to :host

  #validations
  #validates_presence_of :first_name, :last_name, :email, :date_of_birth, :address1, :zipcode, :city, :field_of_study
  #validates_uniqueness_of :user_id
end
