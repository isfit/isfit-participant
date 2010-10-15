class InformationPage < ActiveRecord::Base
  belongs_to :information_category
  belongs_to :user
end
