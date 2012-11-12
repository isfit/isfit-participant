class AddIgnoreDeadlineToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :ignore, :boolean, :default => false
  end
end
