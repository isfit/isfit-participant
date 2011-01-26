class AddDialogueToParticipant < ActiveRecord::Migration
  def self.up
    add_column :participants, :dialogue, :boolean
    add_column :participants, :middle_name, :string
  end

  def self.down
    remove_column :participants, :middle_name
    remove_column :participants, :dialogue
  end
end
