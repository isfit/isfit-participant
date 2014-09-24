class DialogueApplication < ActiveRecord::Base
  # Attributes
  attr_accessible :conflict_essay, :dialogue_essay, :english_proficiency, 
    :relationship_status, :user_id, :vision_essay, :ethnicity, :national, 
    :realtives, :other_information, :profile_attributes

  # Relations
  belongs_to :user

  has_one :profile, through: :user

  accepts_nested_attributes_for :profile, update_only: true

  # Validations
  validates :relationship_status, :english_proficiency, presence: true
  validates :realtives, presence: true
  validates :dialogue_essay, presence: true
  validates :conflict_essay, presence: true
  validates :vision_essay, presence: true

  # Go! Go! Function time!
  def complete?
    !dialogue_essay.blank? && !conflict_essay.blank? && !vision_essay.blank?
  end
end
