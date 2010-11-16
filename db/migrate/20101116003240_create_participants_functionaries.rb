class CreateParticipantsFunctionaries < ActiveRecord::Migration
  def self.up
    create_table :functionaries_participants, :id => false do |t|
      t.integer :participant_id
      t.integer :functionary_id
      t.timestamps
    end
  end

  def self.down
    drop_table :functionaries_participants
  end
end
