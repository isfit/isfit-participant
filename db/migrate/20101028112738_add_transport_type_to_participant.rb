class AddTransportTypeToParticipant < ActiveRecord::Migration
  def self.up
    add_column :participants, :transport_type_id, :integer
  end

  def self.down
    remove_column :participants, :transport_type_id
  end
end
