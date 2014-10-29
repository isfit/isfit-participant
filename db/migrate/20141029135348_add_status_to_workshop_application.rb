class AddStatusToWorkshopApplication < ActiveRecord::Migration
  def change
    add_column :workshop_applications, :status, :integer, limit: 1, default: -1
  end
end
