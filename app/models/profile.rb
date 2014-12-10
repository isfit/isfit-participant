class Profile < ActiveRecord::Base
  CONFLICT_AREAS = ['BI', 'RW', 'ZA']

  DIETARY_LAW_OPTIONS = [
    ['No preference', 0],
    ['Halal', 1],
    ['Kosher', 2],
    ['Vegetarian', 3]
  ]

  attr_accessible :address, :calling_code, :citizenship_id, :city, :country_id, 
    :date_of_birth, :field_of_study, :gender, :gender_specify, :nationality, 
    :phone, :postal_code, :school, :motivation_essay, :next_of_kin_name,
    :next_of_kin_phone, :next_of_kin_address, :next_of_kin_relation, :dietary_law, 
    :other_diet_preferences, :allergy_animals, :allergy_gluten, :allergy_lactose, 
    :allergy_nuts, :other_allergies, :host_gender_preference, :smoke, :handicap, 
    :other_host_preferences

  belongs_to :citizenship, class_name: 'Country'
  belongs_to :country
  belongs_to :user

  # Validation for core profile fields
  validates :date_of_birth,   presence: true
  validates :gender,          presence: true
  validates :nationality,     presence: true
  validates :citizenship_id,  presence: true

  validates :school,          presence: true
  validates :field_of_study,  presence: true

  validates :address,       presence: true
  validates :postal_code,   presence: true
  validates :city,          presence: true
  validates :country_id,    presence: true
  validates :calling_code,  presence: true
  validates :phone,         presence: true, numericality: true

  # Validations for next of kin information
  with_options if: "user.is_participant?" do |p|
    p.validates :next_of_kin_name,      presence: true
    p.validates :next_of_kin_phone,     presence: true
    p.validates :next_of_kin_address,   presence: true
    p.validates :next_of_kin_relation,  presence: true
  end
  
  before_validation :strip_phone_formating_characters

  def related_to_conflict_area?
    citizenship_in_conflict_area? || lives_in_conflict_area?
  end

  def citizenship_in_conflict_area?
    CONFLICT_AREAS.any? { |code| code.eql?(citizenship.code) }
  end

  def lives_in_conflict_area?
    CONFLICT_AREAS.any? { |code| code.eql?(country.code) }
  end

  def next_of_kin_not_completed?
    next_of_kin_name.blank? || next_of_kin_phone.blank? || next_of_kin_address.blank?
  end

  private
    def strip_phone_formating_characters
      self.phone = phone.to_s.gsub(/[^0-9a-zA-Z]/i, '')
    end
end
