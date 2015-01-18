class AddHostLockedToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :host_locked, :boolean
  end
end
