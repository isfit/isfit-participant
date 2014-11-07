class Faq::Question < ActiveRecord::Base
  default_scope { order('question ASC') }

  scope :with_category, -> { joins(:category) }

  # Attributes
  attr_accessible :answer, :question, :category_id

  # Relations
  belongs_to :category, counter_cache: true

  # Validations
  validates_presence_of :answer, :question, :category_id
end
