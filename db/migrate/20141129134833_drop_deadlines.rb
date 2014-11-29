class DropDeadlines < ActiveRecord::Migration
  def up
    drop_table :deadlines
    drop_table :deadlines_users
  end

  def down
    create_table :deadlines do |t|
      t.datetime :deadline
      t.string   :name
      t.datetime :created_at,                      null: false
      t.datetime :updated_at,                      null: false
      t.integer  :participant_type, default: 0
    end
  
    create_table :deadlines_users do |t|
      t.integer  :user_id
      t.integer  :deadline_id
      t.datetime :created_at,                     null: false
      t.datetime :updated_at,                     null: false
      t.boolean  :approved,    default: false
    end
  end
end
