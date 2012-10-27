class AddAttachmentVisumToParticipants < ActiveRecord::Migration
  def self.up
    change_table :participants do |t|
      t.has_attached_file :visum
    end
  end

  def self.down
    drop_attached_file :participants, :visum
  end
end
