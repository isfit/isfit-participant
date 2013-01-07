class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :arrival_place
  has_and_belongs_to_many :functionaries
  has_many :questions
  belongs_to :transport_type
  belongs_to :country
  belongs_to :workshop
  belongs_to :host

  attr_accessible :address1, :sex, :next_of_kin_name, :next_of_kin_phone, 
    :next_of_kin_address, :date_of_birth, :field_of_study, :email, :zipcode, 
    :city, :country_id, :country_citizen_id, :nationality, :vegetarian, 
    :halal, :allergy_lactose, :allergy_gluten, :allergy_nuts, :allergy_pets,
    :allergy_other, :smoke, :handicap, :media_consent

  has_attached_file :visum, {
    :url => "/system/:hash.:extension",
    :hash_secret => "kakekakekakemonster",
  }

  validates_attachment :visum,
    :size => { :in => 0..50.megabytes }

  def self.sortable_fields
    [
      "first_name",
      "last_name",
      "email",
      "country_id",
      "workshop_id",
      "transport_type_id",
      "arrival_place_id",
      "arrives_at",
      "visa_present",
      "accepted_present",
      "has_passport",
      "applied_for_visa",
      "flightnumber",
      "travel_support",
      "need_transport",
      "guaranteed",
    ]
  end

  #validations
  #validates_presence_of :first_name, :last_name, :email, :date_of_birth, :address1, :zipcode, :city, :field_of_study
  #validates_uniqueness_of :user_id
  
  #Next version of participant need validation of email...
end
