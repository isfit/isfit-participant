class AddParticipantTypeToDeadline < ActiveRecord::Migration
  def change
    add_column :deadlines, :participant_type, :integer, :default => 0, :nil => false
  end
end
