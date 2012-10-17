class AddTravelStatusToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :travel_status, :integer, :default => 0, :null => false
  end
end
