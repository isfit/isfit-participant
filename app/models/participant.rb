class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :arrival_place
  has_many :questions
  belongs_to :transport_type
  belongs_to :country
  belongs_to :workshop
  belongs_to :host

  attr_accessible :address1, :sex, :next_of_kin_name, :next_of_kin_phone, 
    :next_of_kin_address, :date_of_birth, :field_of_study, :zipcode,
    :city, :country_id, :country_citizen_id, :nationality, :vegetarian, 
    :halal, :allergy_lactose, :allergy_gluten, :allergy_nuts, :allergy_pets,
    :allergy_other, :smoke, :handicap, :media_consent

  has_attached_file :visum, {
    :url => "/system/:hash.:extension",
    :hash_secret => "kakekakekakemonster",
  }

  validates_attachment :visum,
    :size => { :in => 0..50.megabytes }

  def full_name
    user.full_name
  end

  def first_name
    user.first_name
  end

  def last_name
    user.last_name
  end

  def email
    user.email
  end

  def workshop_name
    if self.workshop
      self.workshop.name
    else
      ""
    end
  end

  def has_host?
    if self.host
      true
    else
      false
    end
  end

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
