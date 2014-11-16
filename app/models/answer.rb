class Answer < ActiveRecord::Base
  # Relations
  belongs_to :question
  belongs_to :user

  # Validations
  validates_presence_of :content
end
