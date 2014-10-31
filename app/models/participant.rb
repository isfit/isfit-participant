class Participant < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :workshop

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

  def needs_visa?
    need_visa == 1 ? true : false
  end
end