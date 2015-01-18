class AddHostIdToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :host_id, :integer
  end
end
