class AddGuaranteedToParticipant < ActiveRecord::Migration
  def self.up
    add_column :participants, :guaranteed, :boolean
  end

  def self.down
    remove_column :participants, :guaranteed
  end
end
