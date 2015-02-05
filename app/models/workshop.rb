class Workshop < ActiveRecord::Base
  attr_accessible :description, :lead, :title
  def full_title
    "#{number}. #{title}"
  end
end
