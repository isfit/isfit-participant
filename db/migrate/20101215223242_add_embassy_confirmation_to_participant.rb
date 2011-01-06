class AddEmbassyConfirmationToParticipant < ActiveRecord::Migration
  def self.up
    add_column :participants, :embassy_confirmation, :integer
  end

  def self.down
    remove_column :participants, :embassy_confirmation
  end
end
