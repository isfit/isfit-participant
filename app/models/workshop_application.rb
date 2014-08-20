class WorkshopApplication < ActiveRecord::Base
  attr_accessible :amount, :applying_for_support, :other_sources, :still_attend, 
    :financial_aid_essay, :workshop_1_id, :workshop_2_id, :workshop_3_id,
    :workshop_essay

  belongs_to :workshop_1, class_name: 'Workshop'
  belongs_to :workshop_2, class_name: 'Workshop'
  belongs_to :workshop_3, class_name: 'Workshop'
  belongs_to :user

  validates_presence_of :workshop_1_id, :workshop_2_id, :workshop_3_id, :user_id
  validates_numericality_of :amount, greater_than_or_equal: 0, 
    unless: :not_applying_for_travel_support?

  def not_applying_for_travel_support?
    !applying_for_support
  end
end
