class AddApprovedToDeadlinesUser < ActiveRecord::Migration
  def change
    add_column :deadlines_users, :approved, :boolean, :default => false
  end
end
