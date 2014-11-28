class DropEvents < ActiveRecord::Migration
  def up
    drop_table :events
  end

  def down
    create_table :events do |t|
      t.string   :name
      t.datetime :start_at
      t.datetime :end_at
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
