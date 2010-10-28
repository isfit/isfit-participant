class CreateTransportTypes < ActiveRecord::Migration
  def self.up
    create_table :transport_types do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :transport_types
  end
end
