class AddSppToParticipants < ActiveRecord::Migration
  def self.up
    add_column :participants, :spp, :boolean
  end

  def self.down
    remove_column :participants, :spp
  end
end
