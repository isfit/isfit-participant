class FinancialAidApplication < ActiveRecord::Base
  validates_presence_of :amount, :essay
  attr_accessible :amount, :can_come_anyway, :essay, :other_sources, :user_id
  belongs_to :user
end
