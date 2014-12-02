class Participant < ActiveRecord::Base
  # Attributes
  attr_accessible :approved_first_deadline, :visa_number, :approved_second_deadline

  # Relations
  belongs_to :user
  belongs_to :workshop

  has_many :questions

  # Validations
  validates :user_id, presence: true, uniqueness: true
  validates :workshop_id, presence: true
  validates :visa_number, presence: true, if: :applied_for_visa

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
end