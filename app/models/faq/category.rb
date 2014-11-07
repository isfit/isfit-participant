class Faq::Category < ActiveRecord::Base
  default_scope order('name ASC')

  scope :with_questions, -> { where('questions_count > 0') }

  # Attribute
  attr_accessible :name

  # Relation
  has_many :questions, dependent: :destroy

  # Validation
  validates :name, presence: true, uniqueness: true
end
