class DialogueApplication < ActiveRecord::Base
  belongs_to :user

  attr_accessible :conflict_essay, :dialogue_essay, :english_proficiency, :french_proficiency, :relationship_status, :user_id, :vision_essay
  validates_presence_of :relationship_status, :french_proficiency, :english_proficiency, :user_id

  def complete?
    !dialogue_essay.blank? && !conflict_essay.blank? && !vision_essay.blank?
  end
end
