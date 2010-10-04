class RolesView < ActiveRecord::Base
  belongs_to :user
  belongs_to :authorizable, :polymorphic => true
end
