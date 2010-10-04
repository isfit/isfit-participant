class Article < ActiveRecord::Base
validates :name, :presence => true
validates :title,:presence => true
belongs_to :functionary
end
