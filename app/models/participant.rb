class Participant < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :workshop

  # Validations
  validates :user_id, presence: true, uniqueness: true
  validates :workshop_id, presence: true
end