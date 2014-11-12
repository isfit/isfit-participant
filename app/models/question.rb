class Question < ActiveRecord::Base
  # Relations
  belongs_to :user
  has_many :answers

  validates_presence_of :content, :subject

  def self.status_options
  	[
  		["New", 1],
  		["Open", 2],
  		["Resolved", 3]
  	]
  end

  def self.status id
  	id += 1 # 1-indeksert istedenfor 0

  	statuses = status_options()
  	statuses[id][0]
  end

  def self.status_new
  	status_options[0][1]
  end

  def self.status_resolved
  	status_options[2][1]
  end
end
