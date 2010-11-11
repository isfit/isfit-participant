class CreateDeadlines < ActiveRecord::Migration
  def self.up
    create_table :deadlines do |t|
      t.timestamp :deadline
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :deadlines
  end
end
