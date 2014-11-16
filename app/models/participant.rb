class Participant < ActiveRecord::Base
  # Attributes
  attr_accessible :approved_first_deadline

  # Relations
  belongs_to :user
  belongs_to :workshop

  has_many :questions

  # Validations
  validates :user_id, presence: true, uniqueness: true
  validates :workshop_id, presence: true

  # Methods
  def not_completed_prepare_visa?
    need_visa == -1 ? true : false
  end

  def not_completed_invitation?
    accepted_invitation == -1 ? true : false
  end

  def not_completed_applied_visa?
    applied_visa == -1 ? true : false
  end

  def needs_visa?
    need_visa == 1 ? true : false
  end
end