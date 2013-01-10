class Host < ActiveRecord::Base
  has_many :participants


  def full_name
    "#{first_name} #{last_name}"
  end

  def full?
    participants.count >= number
  end

  def number_left
    number - participants.count
  end

  def student
    if self[:student].nil?
      "Not registered"
    else
      self[:student] ? "Yes" : "No"
    end
  end
end
