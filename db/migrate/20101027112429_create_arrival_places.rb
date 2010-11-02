class CreateArrivalPlaces < ActiveRecord::Migration
  def self.up
    create_table :arrival_places do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :arrival_places
  end
end
