class FinancialAidApplication < ActiveRecord::Base
  validates_presence_of :amount, :essay
  validates :amount, :inclusion => { :in => 0..3000, :message => "The requested amount must be between 0 and 3000"}
  attr_accessible :amount, :can_come_anyway, :essay, :other_sources, :user_id
  belongs_to :user
end
