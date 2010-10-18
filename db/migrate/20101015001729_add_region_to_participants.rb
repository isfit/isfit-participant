class AddRegionToParticipants < ActiveRecord::Migration
  def self.up
    add_column :participants, :region_id, :int
  end
          
  def self.down
    remove_column :participants, :region_id
  end

end
