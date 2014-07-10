class RemoveFunctionariesParticipants < ActiveRecord::Migration
  def up
    drop_table :functionaries_participants
  end

  def down
    create_table :functionaries_participants, id: false do |t|
      t.integer  :functionary_id
      t.integer  :participant_id
      t.datetime :created_at,     null: false
      t.datetime :updated_at,     null: false
    end
  end
end
