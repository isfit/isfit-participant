class AddSmokeHandicapToParticipant < ActiveRecord::Migration
  def self.up
    add_column :participants, :smoke, :boolean
    add_column :participants, :handicap, :string
    add_column :participants, :allergy_pets, :boolean
  end

  def self.down
    remove_column :participants, :allergy_pets
    remove_column :participants, :handicap
    remove_column :participants, :smoke
  end
end
