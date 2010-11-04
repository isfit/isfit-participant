class AddPressInfoToParticipant < ActiveRecord::Migration
  def self.up
    add_column :participants, :media_consent, :boolean
    add_column :participants, :subscribe_consent, :boolean
  end

  def self.down
    remove_column :participants, :subscribe_consent
    remove_column :participants, :media_consent
  end
end
