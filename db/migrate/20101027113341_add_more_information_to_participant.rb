class AddMoreInformationToParticipant < ActiveRecord::Migration
  def self.up
    add_column :participants, :accepted, :integer
    add_column :participants, :visa, :integer
  end

  def self.down
    remove_column :participants, :visa
    remove_column :participants, :accepted
  end
end
