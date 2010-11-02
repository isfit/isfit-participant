class Article < ActiveRecord::Base
validates :content, :presence => true
validates :title,:presence => true
belongs_to :user
end
