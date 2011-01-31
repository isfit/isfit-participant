class AddFieldsToParticipant < ActiveRecord::Migration
  def self.up
    add_column :participants, :host_id, :integer
    add_column :participants, :checked_in, :datetime
    add_column :participants, :checked_out, :datetime
  end

  def self.down
    remove_column :participants, :checked_in
    remove_column :participants, :checked_out
    remove_column :participants, :host_id
  end
end
