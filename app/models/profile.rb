class Profile < ActiveRecord::Base
  attr_accessible :address, :calling_code, :citizenship_id, :city, :country_id, 
    :date_of_birth, :field_of_study, :gender, :gender_specify, :nationality, 
    :phone, :postal_code, :school, :motivation_essay

  belongs_to :citizenship, class_name: 'Country'
  belongs_to :country
  belongs_to :user

  validates :phone, numericality: true, presence: true
  validates_presence_of :date_of_birth, :gender, :nationality, :citizenship_id, 
    :school, :field_of_study, :address, :postal_code, :city, :country_id,
    :calling_code 
  
  before_validation :strip_phone_formating_characters

  def from_conflict_area?
    ['BI', 'RW', 'ZA'].any? { |code| code.eql?(country.code) }
  end

  private
    def strip_phone_formating_characters
      self.phone = phone.to_s.gsub(/[^0-9a-zA-Z]/i, '')
    end
end
