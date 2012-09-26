class AddEmbassyConfirmationToParticipant < ActiveRecord::Migration
  def self.up
    add_column :participants, :embassy_confirmation, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :participants, :embassy_confirmation
  end
end
