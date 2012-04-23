class Role < ActiveRecord::Base
  # acts_as_authorization_role :subject_class_name => 'User'
  # acts_as_authorization_role 
  has_and_belongs_to_many :users
end
