class InformationPage < ActiveRecord::Base
  validates :content, :presence => true
  validates :title,:presence => true

  belongs_to :information_category
  belongs_to :user
end
