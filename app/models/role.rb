class Role < ActiveRecord::Base
  # acts_as_authorization_role :subject_class_name => 'User'
  # acts_as_authorization_role 
  #has_and_belongs_to_many :users
  has_many :user_roles
  has_many :users, :through => :user_roles
end
