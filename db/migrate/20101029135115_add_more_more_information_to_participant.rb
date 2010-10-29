class AddMoreMoreInformationToParticipant < ActiveRecord::Migration
  def self.up
    add_column :participants, :travel_support, :integer
    add_column :participants, :applied_for_visa, :integer
  end

  def self.down
    remove_column :participants, :applied_for_visa
    remove_column :participants, :travel_support
  end
end
