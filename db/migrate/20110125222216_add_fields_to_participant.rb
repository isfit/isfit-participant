class AddFieldsToParticipant < ActiveRecord::Migration
  def self.up
    add_column :participants, :host_id, :integer
    add_column :participants, :checked_in, :boolean
  end

  def self.down
    remove_column :participants, :checked_in
    remove_column :participants, :host_id
  end
end
