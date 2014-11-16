class Country < ActiveRecord::Base
  # Attributes
  attr_accessible :user_id

  # Relations
  belongs_to :user
end
