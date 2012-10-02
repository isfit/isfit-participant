class Functionary < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :participants

  def full_name
    "#{first_name} #{last_name}"
  end
end
