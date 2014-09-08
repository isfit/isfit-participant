class WorkshopApplication < ActiveRecord::Base
  attr_accessible :amount, :applying_for_support, :other_sources, :still_attend, 
    :financial_aid_essay, :workshop_1_id, :workshop_2_id, :workshop_3_id,
    :workshop_essay

  belongs_to :workshop_1, class_name: 'Workshop'
  belongs_to :workshop_2, class_name: 'Workshop'
  belongs_to :workshop_3, class_name: 'Workshop'
  belongs_to :user

  validates_presence_of :workshop_1_id, :workshop_2_id, :workshop_3_id, :user_id
  validates :amount, numericality: { greater_than: 0 }, 
    if: :applying_for_support

  before_validation do
    self.amount = amount.to_s.gsub(/[^0-9]/i, '') if attribute_present?('amount')
  end

  def complete?
    if applying_for_support
      return false if financial_aid_essay.blank?
    end

    !workshop_essay.blank?
  end
end
