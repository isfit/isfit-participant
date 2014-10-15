class WorkshopApplication < ActiveRecord::Base
  # Scopes
  scope :valid, -> { joins(:user, :profile).where(users: {role: 'applicant'}).where("motivation_essay != ''", "workshop_essay != ''") }
  scope :passed_profile_review, -> { where('profile_grade > 3') }

  scope :wa_reviewed, -> { where('workshop_application_grade IS NOT NULL AND workshop_recommendation_id IS NOT NULL') }
  scope :not_wa_reviewed, -> { where('workshop_application_grade IS NULL OR workshop_recommendation_id IS NULL') }

  scope :has_no_reviewer, -> { where("workshop_application_reviewer_id IS NULL") }

  # Constants
  GRADE_OPTIONS = {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 10
  }

  # Attributes
  attr_accessible :amount, :applying_for_support, :other_sources, :still_attend, 
    :financial_aid_essay, :workshop_1_id, :workshop_2_id, :workshop_3_id,
    :workshop_essay, :profile_attributes, :profile_grade

  # Relations
  belongs_to :profile_reviewer, class_name: 'User'
  belongs_to :workshop_application_reviewer, class_name: 'User'
  belongs_to :user
  belongs_to :workshop_1, class_name: 'Workshop'
  belongs_to :workshop_2, class_name: 'Workshop'
  belongs_to :workshop_3, class_name: 'Workshop'
  belongs_to :workshop_recommendation, class_name: 'Workshop'

  has_one :profile, through: :user

  accepts_nested_attributes_for :profile, update_only: true

  # Valiations
  validates :workshop_1_id, :workshop_2_id, :workshop_3_id, presence: true
  validates :workshop_essay, presence: true
  validates :user_id, presence: true
  validates :amount, numericality: { greater_than: 0 }, if: :applying_for_support
  validates :profile_grade, numericality: GRADE_OPTIONS, allow_blank: true
  validates :workshop_application_grade, numericality: GRADE_OPTIONS, allow_blank: true

  # Callbacks
  before_validation :strip_amount
  
  # Stop! Function time.
  def complete?
    if applying_for_support
      return false if financial_aid_essay.blank?
    end

    !workshop_essay.blank?
  end

  def self.ungraded_applications
    joins(:user, :profile).where(users: {role: 'applicant'}).where("profiles.motivation_essay != ''").where("workshop_essay != ''").where("profile_grade IS NULL")
  end

  private
    def strip_amount
      self.amount = amount.to_s.gsub(/[^0-9]/i, '') if attribute_present?('amount')
    end
end
