class Participant < ActiveRecord::Base
  # Attributes
  attr_accessible :approved_first_deadline, :visa_number, :approved_second_deadline, 
    :arrival_in_norway, :departure_trd, :departure_norway, :trd_arrival_date,
    :trd_arrival_flight_number, :osl_arrival_date, :osl_arrival_flight_number,
    :transfer_to_trd, :other_arrival_information, :trd_departure_date, 
    :trd_departure_flight_number, :other_trondheim_departure_information,
    :osl_departure_date, :osl_departure_flight_number, :other_norway_departure_information,
    :confirmed_participation, :approved_third_deadline, :train_arrival_datetime,
    :train_departure_datetime

  # Relations
  belongs_to :user
  belongs_to :workshop

  has_many :questions
  has_one :host

  # Validations
  validates :user_id, presence: true, uniqueness: true
  validates :workshop_id, presence: true
  validates :visa_number, presence: true, if: :applied_for_visa

  validates :arrival_in_norway, numericality: {greater_than: 0, message: 'must be selected'}, if: :approved_second_deadline?

  with_options if: :arrives_norway_in_oslo? do |b|
    b.validates :osl_arrival_date, presence: true
    b.validates :osl_arrival_flight_number, flight_designator: true
    b.validates :transfer_to_trd, numericality: {greater_than: 0, message: 'must be selected'}
  end

  with_options if: :over_trondheim? do |c|
    c.validates :trd_arrival_date, presence: true
    c.validates :trd_arrival_flight_number, flight_designator: true
  end

  validates :train_arrival_datetime, presence: true, if: :transfers_with_train?

  with_options if: :needs_other? do |e|
    e.validates :other_arrival_information, presence: true
  end

  validates :departure_trd, numericality: {greater_than: 0, message: 'must be selected'}, if: :approved_second_deadline?

  with_options if: :departs_trondheim_by_flight? do |f|
    f.validates :trd_departure_date, presence: true
    f.validates :trd_departure_flight_number, flight_designator: true
  end

  validates :train_departure_datetime, presence: true, if: :departs_with_train?
  validates :other_trondheim_departure_information, presence: true, if: :departs_trondheim_by_other?

  validates :departure_norway, numericality: {greater_than: 0, message: 'must be selected'}, if: :approved_second_deadline?

  with_options if: :departs_norway_by_osl? do |g|
    g.validates :osl_departure_date, presence: true
    g.validates :osl_departure_flight_number, flight_designator: true
  end

  validates :other_norway_departure_information, presence: true, if: :departs_norway_by_other?

  # Methods
  def not_completed_prepare_visa?
    need_visa == -1 ? true : false
  end

  def not_completed_invitation?
    accepted_invitation == -1 ? true : false
  end

  def not_completed_applied_visa?
    [-1, 2].any? { |code| code == applied_visa } ? true : false
  end

  def needs_visa?
    need_visa == 1 ? true : false
  end

  def applied_for_visa
    need_visa == 1 && applied_visa == 1
  end

  def approved_second_deadline?
    approved_second_deadline == 1 ? true : false
  end

  def arrives_norway_in_trondheim?
    arrival_in_norway == 1 ? true : false
  end

  def over_trondheim?
    arrival_in_norway == 1 || transfer_to_trd == 1 ? true : false
  end

  def arrives_norway_in_oslo?
    arrival_in_norway == 2 ? true : false
  end

  def arrives_norway_by_other?
    arrival_in_norway == 3 ? true : false
  end

  def needs_other?
    arrival_in_norway == 3 || transfer_to_trd == 2 ? true : false
  end

  def departs_trondheim_by_flight?
    departure_trd == 1 ? true : false
  end

  def departs_trondheim_by_other?
    departure_trd == 2 ? true : false
  end

  def departs_norway_by_osl?
    departure_norway == 2 ? true : false
  end

  def departs_norway_by_other?
    departure_norway == 3 ? true : false
  end

  def confirmed_participation?
    confirmed_participation == 1 ? true : false
  end

  def transfers_with_train?
    transfer_to_trd == 3 ? true : false
  end 

  def departs_with_train?
    departure_trd == 3 ? true : false
  end 
end