class Question < ActiveRecord::Base
  belongs_to :participant
  has_many :answers
end
