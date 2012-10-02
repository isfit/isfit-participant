class Application < ActiveRecord::Base
  attr_accessible :address, :birthdate, :city, :country_id, :email, :essay1, 
    :essay2, :field_of_study, :first_name, :last_name, :phone, :sex, 
    :travel_amount, :travel_apply, :travel_essay, :travel_nosupport_cancome, 
    :travel_nosupport_other, :university, :workshop1, :workshop2, :workshop3, 
    :zipcode, :grade1_functionary_id, :grade1, :grade1_comment, 
    :grade2_functionary_id, :grade2, :grade2_comment, :selection_functionary_id, 
    :total_grade, :selection_comment, :travel_functionary_id, :travel_approved, 
    :travel_amount_given, :travel_comment, :status, :final_workshop, :deleted

  belongs_to :country
  has_and_belongs_to_many :functionaries

  UNRANSACKABLE_ATTRIBUTES = ["id", "address", "essay1", "essay2", "field_of_study", 
    "phone", "grade1_functionary_id","grade1_comment", "grade2_functionary_id", 
    "grade2_comment", "created_at", "updated_at", "deleted", "university"]

  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

  #Validations
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :address
  validates_presence_of :zipcode
  validates_presence_of :city
  validates_inclusion_of :country_id, :in => 1..210, :message => "not selected"
  validates_presence_of :phone
  validates_presence_of :sex,  :message => "must be selected"
  validates_presence_of :university
  validates_presence_of :field_of_study

  validates_format_of :email,
    :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
    :message => 'address is invalid.'
  validates_confirmation_of :email, :message => "address should match confirmation."
  validates_uniqueness_of :email, :message => " address is already in user_role."

  validates_inclusion_of :birthdate, :in => Date.new(1911)..Date.new(1995,2,7), 
    :message => "You need to be 18 years old when the festival starts"

  validates_numericality_of :workshop1,:greater_than => 0, :message => "not selected"
  validates_numericality_of :workshop2,:greater_than => 0, :messageessage => "not selected"
  validates_numericality_of :workshop3,:greater_than_than => 0, :message => "not selected"
  validates_exclusion_of :workshop1, :in => lambda { |p| [p.workshop2, p.workshop3] }, :message => "Please choose different workshops"
  validates_exclusion_of :workshop2, :in => lambda { |p| [p.workshop1, p.workshop3] }, :message => "Please choose different workshops"
  validates_exclusion_of :workshop3, :in => lambda { |p| [p.workshop1, p.workshop2] }, :message => "Please choose different workshops"

  validates_presence_of :essay1
  validates_presence_of :essay2
  validates_length_of :essay1, :maximum=>3000, :message => "Essay 1 too long"
  validates_length_of :essay2, :maximum=>3000, :message => "Essay 2 too long"
  validates :essay1, :length => {
    :maximum   => 260,
    :tokenizer => lambda { |str| str.scan(/\s+|$/) },
    :too_long  => " too long, maximum 300 words"
  }
  validates :essay2, :length => {
    :maximum   => 310,
    :tokenizer => lambda { |str| str.scan(/\s+|$/) },
    :too_long  => "too long, maximum 300 words"
  }

  validates_length_of :travel_essay, :maximum=>2000, :message => "Travel essay too long"
  validates_presence_of :travel_essay, 
    :if => Proc.new { |n| n.travel_apply > 0 }
  validates_presence_of :travel_amount, 
    :if => Proc.new { |n| n.travel_apply > 0 }
  validates_numericality_of :travel_amount, :less_than_or_equal_to => 3000, :greater_than => 0,
    :if => Proc.new { |n| n.travel_apply > 0 || !n.travel_amount.empty? },
    :message => "must be a number, between 0 and 3000"
  validates :travel_essay, :length => {
    :maximum   => 210,
    :tokenizer => lambda { |str| str.scan(/\s+|$/) },
    :too_long  => "too long, maximum 200 words"
  }

  validates_numericality_of :grade1, :less_than_or_equal_to => 10, :greater_than_or_equal_to => 0, 
    :message => "must be a number between 0-10"
  validates_numericality_of :grade2, :less_than_or_equal_to => 10, :greater_than_or_equal_to => 0, 
    :message => "must be a number between 0-10"
  validates_numericality_of :status, :greater_than_or_equal_to => 0, :less_than => 4,
    :message => "Status is invalid"
  validates_numericality_of :final_workshop, :greater_than_or_equal_to => 0,
    :message => "Workshop is invalid"
  validates_numericality_of :travel_amount_given, :less_than_or_equal_to => 3000, :greater_than => 0,
    :if => Proc.new { |n| n.travel_approved > 0 },
    :message => "Travel amount be greater than 0 and below 3000"
  validates_numericality_of :travel_amount_given, :less_than_or_equal_to => 0,
    :if => Proc.new { |n| n.travel_approved == 0 },
    :message => "Travel amount should not be specified, when travel support not is granted."
 
end
