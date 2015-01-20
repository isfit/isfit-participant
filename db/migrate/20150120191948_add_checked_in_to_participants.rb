class AddCheckedInToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :checked_in, :boolean
    add_column :participants, :check_in_time, :datetime
  end
end
