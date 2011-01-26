class AddNotifiedToParticipant < ActiveRecord::Migration
  def self.up
    add_column :participants, :notified, :integer
  end

  def self.down
    remove_column :participants, :notified
  end
end
