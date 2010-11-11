class Functionary < ActiveRecord::Base
  belongs_to :user
  has_many :participants
end
