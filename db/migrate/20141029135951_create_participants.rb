class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :workshop_id
      t.integer :accepted_invitation, limit: 1, default: -1
      t.integer :user_id

      t.timestamps
    end

    add_index :participants, :workshop_id
    add_index :participants, :user_id
  end
end
