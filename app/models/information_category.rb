class InformationCategory < ActiveRecord::Base
  validates :title, :presence => true
  has_many :information_pages
end
