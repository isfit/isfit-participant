class DeadlinesUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :deadline
end
