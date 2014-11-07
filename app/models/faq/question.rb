class Faq::Question < ActiveRecord::Base
  # Attributes
  attr_accessible :answer, :question, :category_id

  # Relations
  belongs_to :category

  # Validations
  validates_presence_of :answer, :question, :category_id
end
