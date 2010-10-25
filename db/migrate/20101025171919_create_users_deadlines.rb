class CreateUsersDeadlines < ActiveRecord::Migration
  def self.up
    create_table :users_deadlines do |t|
      t.integer :user_id
      t.integer :deadline_id
      t.timestamps
    end
  end

  def self.down
    drop_table :users_deadlines
  end
end
