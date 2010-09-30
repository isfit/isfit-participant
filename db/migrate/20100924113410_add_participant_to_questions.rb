class AddParticipantToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :participant_id, :int
  end

  def self.down
    remove_column :questions, :participant_id
  end
end
