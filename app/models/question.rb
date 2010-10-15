class Question < ActiveRecord::Base
  belongs_to :participant
  has_many :questions
  has_many :answers
  validates_presence_of :content, :subject
end
